#!/usr/bin/env bash

# The following docker will be generated:
#  - flow.ci.backend: it includes api and control center
#  - flow.ci.agent:

# How to run flow.ci
# - backend: 'docker-compose up'
# - agent: docker run --network=host -e FLOW_ZOOKEEPER_HOST=127.0.0.1:2181 -e FLOW_AGENT_ZONE=default -e FLOW_AGENT_NAME={agent name} flow.ci.agent

cd ../flow-platform

# mvn build artifact of each components
mvn clean install -DskipTests=true

cd ../docker
docker build -t flow.ci.git:0.0.1 -f ./Dockerfile-git .

# build docker image for flow.ci backend
docker build -t flow.ci.backend:0.0.1 -f ./Dockerfile-backend .

# build docker compose service for flow.ci backend
cd ../docker
docker-compose rm -f
docker-compose build

# build docker image for flow.ci agent
docker build -t flow.ci.agent:0.0.1 -f ./Dockerfile-agent .


cd ../flow-web

FLOW_WEB_API=http://localhost:8080/flow-api   npm run  build
DOCKER_PATH=/docker/

cd ../docker
docker build -t flow.web:0.0.1 -f ./Dockerfile-web .