#!/bin/bash

python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --clear --noinput
python manage.py check --deploy
gunicorn {{cookiecutter.project_slug}}.asgi:application -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8000