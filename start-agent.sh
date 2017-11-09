#!/usr/bin/env bash
# example ./start-agent.sh http://127.0.0.1:8080 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe

FLOW_ZOOKEEPER_HOST=127.0.0.1:2181
DOCKER_IMAGE_AGENT=flowci/flow.ci.agent

if [[ ! -n $USE_DOCKER ]]; then
	echo "start agent use jar"
	java -jar ./agent/flow-agent.jar $1/flow-api $2
else
	echo "start agent use docker"
	docker run --network=host -e FLOW_ZOOKEEPER_HOST=$FLOW_ZOOKEEPER_HOST -v ~/.ssh:/root/.ssh -e FLOW_BASE_URL=$1/flow-api -e FLOW_TOKEN=$2 -d $DOCKER_IMAGE_AGENT
fi


echo "=============================start agent success============================="