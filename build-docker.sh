#!/usr/bin/env bash

FLOW_PLATFORM_PATH=../flow-platform
FLOW_WEB_PATH=../flow-web
FLOW_DOCKER_PATH=../docker

cd $FLOW_PLATFORM_PATH
mvn clean install -DskipTests=true

cd $FLOW_DOCKER_PATH
# cp target to docker folder
mkdir -p ./target
cp $FLOW_PLATFORM_PATH/dist/flow-control-center-*.war ./target/flow-control-center.war
cp $FLOW_PLATFORM_PATH/dist/flow-api-*.war ./target/flow-api.war

# build docker image for flow.ci git
docker build -t flow.ci.git -f ./Dockerfile-git .

# build docker image for flow.ci backend
docker build -t flow.ci.backend -f ./Dockerfile-backend .

# build docker compose service for flow.ci backend
docker-compose rm -f
docker-compose build

cp $FLOW_PLATFORM_PATH/dist/flow-agent-*.jar ./target
# build docker image for flow.ci agent
docker build -t flow.ci.agent -f ./Dockerfile-agent .

# build web
cd $FLOW_WEB_PATH
FLOW_WEB_API=http://localhost:8080/flow-api   npm run build

cd $FLOW_DOCKER_PATH
cp -r $FLOW_WEB_PATH/dist ./target
docker build -t flow.web -f ./Dockerfile-web .
