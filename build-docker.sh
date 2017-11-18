#!/usr/bin/env bash

echo "###########环境变量说明###########"

if [[ ! -n $DOCKER_NAME_FLOWCI_AGENT ]]; then
	export DOCKER_NAME_FLOWCI_AGENT=flow.ci.agent
fi
echo "环境变量 DOCKER_NAME_FLOWCI_AGENT: FlowApi build 的 docker 名称，默认 flow.ci.agent, 当前参数值是 ${DOCKER_NAME_FLOWCI_AGENT}"

if [[ ! -n $DOCKER_NAME_FLOWCI ]]; then
	export DOCKER_NAME_FLOWCI=flow.ci.backend
fi
echo "环境变量 DOCKER_NAME_FLOWCI: FlowApi build 的 docker 名称，默认 flow.ci.backend, 当前参数值是 ${DOCKER_NAME_FLOWCI}"

if [[ ! -n $DOCKER_NAME_FLOW_WEB ]]; then
	export DOCKER_NAME_FLOW_WEB=flow.web
fi
echo "环境变量 DOCKER_NAME_FLOW_WEB: FlowWeb build 的 docker 名称，默认 flow.web, , 当前参数值是 ${DOCKER_NAME_FLOW_WEB}"

FLOW_PLATFORM_PATH=../flow-platform
FLOW_WEB_PATH=../flow-web
FLOW_DOCKER_PATH=../docker
PLACEHOLDER=:FLOWCI:

if [[ ! -d  $FLOW_PLATFORM_PATH ]]; then
	echo "请确保 flow-platform 与 docker 项目在同一目录下"
	exit;
fi

if [[ ! -d  $FLOW_WEB_PATH ]]; then
	echo "请确保 flow-web 与 docker 项目在同一目录下"
	exit;
fi


cd $FLOW_PLATFORM_PATH
mvn clean install -DskipTests=true

cd $FLOW_DOCKER_PATH
# cp target to docker folder
mkdir -p ./target
cp $FLOW_PLATFORM_PATH/dist/flow-control-center-*.war ./target/flow-control-center.war
cp $FLOW_PLATFORM_PATH/dist/flow-api-*.war ./target/flow-api.war

# build docker image for flow.ci git
# docker build -t flow.ci.git -f ./Dockerfile-git .

# build docker image for flow.ci backend
docker build -t $DOCKER_NAME_FLOWCI -f ./Dockerfile-backend .

# build docker compose service for flow.ci backend
docker-compose rm -f
docker-compose build

cp $FLOW_PLATFORM_PATH/dist/flow-agent-*.jar ./target
# build docker image for flow.ci agent
docker build -t $DOCKER_NAME_FLOWCI_AGENT -f ./Dockerfile-agent .

# build web
cd $FLOW_WEB_PATH
FLOW_WEB_API=$PLACEHOLDER   npm run build

cd $FLOW_DOCKER_PATH
cp -r $FLOW_WEB_PATH/dist ./target
docker build -t $DOCKER_NAME_FLOW_WEB -f ./Dockerfile-web .
