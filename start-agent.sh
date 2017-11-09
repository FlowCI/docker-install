#!/usr/bin/env bash
# example ./start-agent.sh http://127.0.0.1:8080 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe
# example USER_DOCKER=true ./start-agent.sh http://127.0.0.1:8080 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe

if [[ ! -n $USE_DOCKER ]]; then
	echo "###################Start Agent Using jar#######################"
	java -jar ./agent/flow-agent.jar $1/flow-api $2
else
	echo "###################Start Agent Using Docker#######################"
	if [[ ! -n $FLOW_ZOOKEEPER_HOST ]]; then
		export FLOW_ZOOKEEPER_HOST=127.0.0.1:2181
	fi
	echo "环境变量 FLOW_ZOOKEEPER_HOST: Zookeeper地址, 默认是 127.0.0.1:2181, 当前参数值是 $FLOW_ZOOKEEPER_HOST"

	if [[ ! -n $DOCKER_IMAGE_AGENT ]]; then
		export DOCKER_IMAGE_AGENT=flowci/flow.ci.agent
	fi
	echo "环境变量 DOCKER_IMAGE_AGENT: Agent 的 docker 镜像地址, 默认是官方镜像 flowci/flow.ci.agent, 当前参数值是 $DOCKER_IMAGE_AGENT"

	docker run --network=host -e FLOW_ZOOKEEPER_HOST=$FLOW_ZOOKEEPER_HOST -v ~/.ssh:/root/.ssh -e FLOW_BASE_URL=$1/flow-api -e FLOW_TOKEN=$2 -d $DOCKER_IMAGE_AGENT
fi


echo "=============================start agent success============================="