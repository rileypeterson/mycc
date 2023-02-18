#!/bin/bash
# https://serverfault.com/questions/119273/how-to-use-my-aliases-in-my-crontab
shopt -s expand_aliases
. aliases.sh

# Variables
domains=({{cookiecutter.domain_name}})
rsa_key_size=4096
data_path="./docker/certbot"
email={{cookiecutter.email}}
staging=1 # Set to 1 if you're testing your setup to avoid hitting request limits

if [ -d "$data_path/conf/live/" ]; then
  echo "### Certbot directories already exist. Re-deploying ..."
  prod-down
  prod-up-detach
  echo
  return 0
fi

if [ ! -e "$data_path/conf/options-ssl-nginx.conf" ] || [ ! -e "$data_path/conf/ssl-dhparams.pem" ]; then
  echo "### Downloading recommended TLS parameters ..."
  mkdir -p "$data_path/conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "$data_path/conf/options-ssl-nginx.conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "$data_path/conf/ssl-dhparams.pem"
  echo
fi

echo "### Creating dummy certificate for $domains ..."
path="/etc/letsencrypt/live/$domains"
mkdir -p "$data_path/conf/live/$domains"
docker compose --env-file ./config/.prod.env -f docker/docker-compose.prod.yml run --rm --entrypoint "\
  openssl req -x509 -nodes -newkey rsa:$rsa_key_size -days 1\
    -keyout '$path/privkey.pem' \
    -out '$path/fullchain.pem' \
    -subj '/CN=localhost'" certbot
echo

echo "### Stopping and Starting containers ..."
prod-down
prod-up-detach
sleep 90

echo "### Deleting dummy certificate for $domains ..."
docker compose --env-file ./config/.prod.env -f docker/docker-compose.prod.yml run --rm --entrypoint "\
  rm -Rf /etc/letsencrypt/live/$domains && \
  rm -Rf /etc/letsencrypt/archive/$domains && \
  rm -Rf /etc/letsencrypt/renewal/$domains.conf" certbot
echo

echo "### Requesting Let's Encrypt certificate for $domains ..."
#Join $domains to -d args
domain_args=""
for domain in "${domains[@]}"; do
  domain_args="$domain_args -d $domain"
done

# Select appropriate email arg
case "$email" in
  "") email_arg="--register-unsafely-without-email" ;;
  *) email_arg="--email $email" ;;
esac

# Enable staging mode if needed
# Spent like 6 hours trying to figure out why staging was still happening and it was
# because there wasn't this else statement in the original script
# https://github.com/wmnnd/nginx-certbot/blob/master/init-letsencrypt.sh
# Finally, I think I can get this working consistently...
if [ $staging != "0" ]; then staging_arg="--staging"; else staging_arg=""; fi

docker compose --env-file ./config/.prod.env -f docker/docker-compose.prod.yml run --rm --entrypoint "\
  certbot certonly --webroot -w /var/www/certbot \
    $staging_arg \
    $email_arg \
    $domain_args \
    --rsa-key-size $rsa_key_size \
    --agree-tos \
    --no-eff-email \
    --force-renewal" certbot
echo

echo "### Changing certbot file permissions"
sudo chown -R $USER:$USER docker/certbot

echo "### Reloading NGINX ..."
nginx-reload