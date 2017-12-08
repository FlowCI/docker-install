#!/usr/bin/env bash
# example ./start-agent.sh 127.0.0.1 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe
# example USER_DOCKER=true ./start-agent.sh 127.0.0.1 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe

AGENT_VERSION=v0.1.3-alpha

# set default port, default is 8080
if [[ ! -n $PORT ]]; then
	export PORT=8080
fi

if [[ ! -n $USE_DOCKER ]]; then
	echo "###################Start Agent Using jar#######################"
	AGENT_FILE_NAME=flow-agent-${AGENT_VERSION}.jar

	nohup java -jar ./agent/${AGENT_FILE_NAME} http://${1}:${PORT}/flow-api $2 &
else
	if [[ ! -n $DOCKER_IMAGE_AGENT ]]; then
		export DOCKER_IMAGE_AGENT=flowci/flow-agent:latest
	fi
	echo "环境变量 DOCKER_IMAGE_AGENT: Agent 的 docker 镜像地址, 默认是官方镜像 flowci/flow.ci.agent, 当前参数值是 $DOCKER_IMAGE_AGENT"

	docker run --network=host -v ~/.ssh:/root/.ssh -e FLOW_BASE_URL=http://$1:${PORT}/flow-api -e FLOW_TOKEN=$2 -d $DOCKER_IMAGE_AGENT
fi


echo "=============================start agent success============================="