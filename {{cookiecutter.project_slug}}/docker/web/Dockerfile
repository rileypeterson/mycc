# syntax=docker/dockerfile:1
FROM python:3.10-alpine
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /web
# Copies in requirements.txt, scripts, and Dockerfile into /web
# Then once all installed, switch to project directory
COPY . .
RUN \
 apk update && \
 apk upgrade && \
 apk add postgresql-libs && \
 apk add --virtual .build-deps gcc musl-dev postgresql-dev && \
 python3 -m pip install -r requirements.txt && \
 apk add bash && \
 apk --purge del .build-deps
WORKDIR /{{cookiecutter.project_slug}}
