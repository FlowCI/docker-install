#!/usr/bin/env bash

## the script to initialize ssh-host pool environment

docker pull flowci/agent:latest
docker volume create pyenv
docker run --rm -v pyenv:/target flowci/pyenv:1.3 bash -c "/ws/init-pyenv-volume.sh"