#!/bin/bash

alias dev-down="docker compose --env-file ./config/.dev.env -f docker/docker-compose.dev.yml down"
alias dev-up="docker compose --env-file ./config/.dev.env -f docker/docker-compose.dev.yml up"
alias dev-up-build="dev-down && docker compose --env-file ./config/.dev.env -f docker/docker-compose.dev.yml up --build"
alias prod-down="docker compose --env-file ./config/.prod.env -f docker/docker-compose.prod.yml down"
alias prod-up-build="prod-down && docker compose --env-file ./config/.prod.env -f docker/docker-compose.prod.yml up --build"
alias prod-up-detach="prod-down && docker compose --env-file ./config/.prod.env -f docker/docker-compose.prod.yml up --build --detach"
alias nginx-reload="docker compose --env-file ./config/.prod.env -f docker/docker-compose.prod.yml exec nginx nginx -s reload"
alias logs="docker compose --env-file ./config/.prod.env -f docker/docker-compose.prod.yml logs --follow"
#alias deploy="source scripts/deploy.sh"