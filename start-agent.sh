#!/usr/bin/env bash

## The script used to start flow.ci agent from docker ##
##
### HOW TO START: ./start-agent.sh http://{server ip}:{server port} {token from admin page}
### EXAMPLE: ./start-agent.sh http://172.20.10.4:8080 cfc4a6f1-a2ea-4263-83b2-5f68eadaecbe
### HINT: The "localhost" or "127.0.0.1" is NOT applicable for argument {server ip}

FLOWCI_SERVER_HOST=$1
FLOWCI_SERVER_PORT=8080
FLOWCI_AGENT_TOKEN=$2

if [[ ! -n $FLOWCI_SERVER_HOST ]]; then
	echo "[ERROR] Server host is required"
	exit 1
fi

if [[ ! -n $FLOWCI_AGENT_TOKEN ]]; then
	echo "[ERROR] Agent token is required"
	exit 1
fi

docker run \
-e FLOWCI_SERVER_URL=http://$FLOWCI_SERVER_HOST:$FLOWCI_SERVER_PORT \
-e FLOWCI_AGENT_TOKEN=$FLOWCI_AGENT_TOKEN \
-v $HOME/.flow.ci.agent:/root/.flow.ci.agent \
flowci/agent
