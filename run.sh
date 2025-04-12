#!/bin/bash

if [[ ! -x "$(command -v docker)" ]]; then
    printf "\033[0;34m── \033[0m\033[0;31mDocker is not installed.\033[0m\n"
    exit 1
fi

if [[ ! -x "$(command -v docker-compose)" ]]; then
    printf "\033[0;34m── \033[0m\033[0;31mDocker compose is not installed.\033[0m\n"
    exit 1
fi

if [[ ! -f "docker-compose.yml" ]]; then
    curl -fsSLo docker-compose.yml https://raw.githubusercontent.com/RedstoneWizard08/Eaglercraft-Docker/main/docker-compose.yml
fi

if [[ -z "$1" ]]; then
    printf "\033[0;34m┌─ \033[0m\033[0;36mUsage:\033[0m\n\033[0;34m└─┬─ \033[0m./run.sh start - Starts the server.\033[0m\n\033[0;34m  └─ \033[0m./run.sh stop - Stops the server.\033[0m\n"
    exit 1
fi

running="$(docker-compose ps --services --filter "status=running")"
services="$(docker-compose ps --services)"

if [[ "$1" == "start" ]]; then
    if [[ "$running" != "$services" ]]; then
        printf "\033[0;34m── \033[0m\033[0;36mStarting the server...\033[0m\n"
        docker-compose up -d
        printf "\033[0;34m── \033[0m\033[0;36mDone!\033[0m\n"
        exit 0
    else
        printf "\033[0;34m── \033[0m\033[0;31mThe server is running.\033[0m\n"
        exit 1
    fi
fi

if [[ "$1" == "stop" ]]; then
    if [[ "$running" != "$services" ]]; then
        printf "\033[0;34m── \033[0m\033[0;31mThe server is not running.\033[0m\n"
        exit 1
    else
        printf "\033[0;34m── \033[0m\033[0;36mStopping the server...\033[0m\n"
        docker-compose down
        printf "\033[0;34m── \033[0m\033[0;36mDone!\033[0m\n"
        exit 0
    fi
fi
  