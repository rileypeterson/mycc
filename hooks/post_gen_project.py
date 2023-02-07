import secrets
import glob


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

path = "{{cookiecutter.project_slug}}/{{cookiecutter.project_slug}}/pages/templates/pages/*.html"
html_files = glob.glob(path)
# Hash for project_name
hash = "B29219FED19467B13C"

for file in html_files:
    with open(file) as f:
        t = f.read().replace(hash, "{{cookiecutter.project_name}}")
    with open(file, "w") as f:
        f.write(t)
