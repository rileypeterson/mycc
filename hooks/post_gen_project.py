import time
import os
import subprocess

folder = "{{ cookiecutter.project_slug }}"

with open("/Users/riley/Documents/foo.txt", "w") as f:
    f.write(os.getcwd())
