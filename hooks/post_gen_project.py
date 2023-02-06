import secrets

with open("config/.dev.env", "w") as f:
    f.write(f"SECRET_KEY={secrets.token_urlsafe(128)}\n")
