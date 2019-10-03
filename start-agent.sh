#!/usr/bin/env bash

## The script used to start flow.ci agent from docker ##
##
### HOW TO START: ./start-agent.sh {server ip} {token from admin page}
### EXAMPLE: ./start-agent.sh 172.20.10.4 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe
### HINT: The "localhost" or "127.0.0.1" is NOT applicable for argument {server ip}

FLOWCI_SERVER_HOST=$1
FLOWCI_SERVER_PORT=8080
FLOWCI_AGENT_TOKEN=$2

## To define where to store the data of ci agent in host
FLOWCI_AGENT_HOST_DIR=$HOME/.flow.ci.agent
mkdir -p $FLOWCI_AGENT_HOST_DIR

if [[ ! -n $FLOWCI_SERVER_HOST ]]; then
	echo "[ERROR] Server host is required, ex: ./start-agent.sh 172.20.10.4 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe"
	exit 1
fi

if [[ ! -n $FLOWCI_AGENT_TOKEN ]]; then
	echo "[ERROR] Agent token is required, ex: ./start-agent.sh 172.20.10.4 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe"
	exit 1
fi

docker run \
-e FLOWCI_SERVER_URL=http://$FLOWCI_SERVER_HOST:$FLOWCI_SERVER_PORT \
-e FLOWCI_AGENT_TOKEN=$FLOWCI_AGENT_TOKEN \
-v $FLOWCI_AGENT_HOST_DIR:/root/.flow.ci.agent \
--privileged=true \
flowci/agent
