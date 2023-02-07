import secrets

with open("config/.dev.env", "w") as f:
    # Database
    f.write(f"POSTGRES_DB=dev\n")
    f.write(f"POSTGRES_USER=dev\n")
    f.write(f"POSTGRES_NAME=dev\n")
    f.write(f"POSTGRES_PASSWORD={secrets.token_urlsafe(32)}\n")

    # Django
    f.write("HOST_IP={{cookiecutter.host_ip}}\n")
    f.write(f"DDNS_IP={{cookiecutter.domain_name}}\n")
    f.write(f"SECRET_KEY={secrets.token_urlsafe(128)}\n")
    f.write(f"DEBUG=1\n")
