#!/bin/bash

alias dev-down="docker compose --env-file ./config/.dev.env -f docker/docker-compose.dev.yml down"
alias dev-up="docker compose --env-file ./config/.dev.env -f docker/docker-compose.dev.yml up"
alias dev-up-build="dev-down && docker compose --env-file ./config/.dev.env -f docker/docker-compose.dev.yml up --build"
