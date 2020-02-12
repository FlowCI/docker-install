#!/usr/bin/env bash

## The script used to start flow.ci agent from docker ##
##
### HOW TO START: ./start-agent.sh {server ip} {token from admin page}
### EXAMPLE: ./start-agent.sh http://172.20.10.4:8080 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe

FLOWCI_SERVER_URL=$1
FLOWCI_AGENT_TOKEN=$2

## To define where to store the data of ci agent in host
FLOWCI_AGENT_HOST_DIR=$HOME/.flow.ci.agent
mkdir -p $FLOWCI_AGENT_HOST_DIR

if [[ ! -n $FLOWCI_SERVER_URL ]]; then
	echo "[ERROR] Server host is missing, ./start-agent.sh {server host} {agent token}"
	echo "Example: ./start-agent.sh http://172.20.10.4:8080 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe"
	exit 1
fi

if [[ ! -n $FLOWCI_AGENT_TOKEN ]]; then
	echo "[ERROR] Agent token is missing, ./start-agent.sh {server host} {agent token}"
	echo "Example: ./start-agent.sh http://172.20.10.4:8080 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe"
	exit 1
fi

CONTAINER_NAME="flowci-agent-$FLOWCI_AGENT_TOKEN"
RUNNING_CONTAINER=$(docker ps -aq -f name=$CONTAINER_NAME -f status=running)
EXISTED_CONTAINER=$(docker ps -aq -f name=$CONTAINER_NAME -f status=exited)

if [[ -n $RUNNING_CONTAINER ]]; then
	
	echo "Agent with token $FLOWCI_AGENT_TOKEN is running"

elif [[ -n $EXISTED_CONTAINER ]]; then
	
	echo "Agent with token $FLOWCI_AGENT_TOKEN will restarted"
	docker start -i $EXISTED_CONTAINER

else
	docker run -it \
	--name $CONTAINER_NAME \
	-e FLOWCI_SERVER_URL=$FLOWCI_SERVER_URL \
	-e FLOWCI_AGENT_TOKEN=$FLOWCI_AGENT_TOKEN \
	-v $FLOWCI_AGENT_HOST_DIR:/root/.flow.ci.agent \
	-v /var/run/docker.sock:/var/run/docker.sock \
	flowci/agent
fi
