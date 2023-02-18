import subprocess
import ipaddress
import os
import datetime

if os.getcwd().startswith("/tasks"):
    # In tasks container
    prefix = "/tasks"
else:
    # On dev
    prefix = "../nginx"

allowed_domains_file = f"{prefix}/ddns/allowed_domains.txt"
allowed_ips_file = f"{prefix}/ddns/allowed_ips.conf"

address_list = []
with open(allowed_domains_file) as f:
    for domain in f.readlines():
        domain = domain.strip()
        s = subprocess.check_output(
            ["host", "-R", "1", "-t", "A", f"{domain}"], shell=False
        )
        s = s.decode()
        s = s.split()[-1]
        ip = format(ipaddress.ip_address(s))
        address_list.append((domain, ip))

with open(allowed_ips_file, "w") as f:
    for d, i in address_list:
        timestamp_now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        f.write(f"allow {i};    # {d} {timestamp_now} \n")
