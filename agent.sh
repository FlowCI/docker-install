#!/usr/bin/env bash

## The script used to start flow.ci agent from docker ##

printHelp() 
{
	echo ""
   	echo "Usage: $0 [OPTIONS] COMMAND"

	echo ""
	echo "Example: ./agent.sh -t tokenfromciserver -u http://172.20.10.4:8080 start"

	echo ""
	echo "Options:"
	echo -e " -t\t Agent token from ci server"
   	echo -e " -u\t Server url"

	echo ""
	echo "Commands:"
	echo -e " start\t start an agent"
	echo -e " stop\t stop an agnet"
	echo -e " clean\t remove agent container"
	echo -e " help\t print help message"
	
   	exit 1 # Exit script after printing help
}

checkUrlArg() 
{
	if [[ ! -n $URL ]]; then
		echo "[ERROR] Server url is missing..."
		printHelp
	fi
}

checkTokenArg()
{
	if [[ ! -n $TOKEN ]]; then
		echo "[ERROR] Agent token is missing..."
		printHelp
	fi
}

start()
{
	AGENT_HOST_DIR=$HOME/.agent.$TOKEN
	mkdir -p $AGENT_HOST_DIR

	if [[ -n $RUNNING_CONTAINER ]]; then
		
		echo "Agent with token $TOKEN is running"

	elif [[ -n $EXISTED_CONTAINER ]]; then
		
		echo "Agent with token $TOKEN will restarted"
		docker start -i $EXISTED_CONTAINER

	else
		docker run -it \
		--name $CONTAINER_NAME \
		-e FLOWCI_SERVER_URL=$URL \
		-e FLOWCI_AGENT_TOKEN=$TOKEN \
		-v $AGENT_HOST_DIR:/root/.flow.ci.agent \
		-v /var/run/docker.sock:/var/run/docker.sock \
		flowci/agent
	fi
}

while getopts ":t:u:p" arg; do
  case $arg in
    t) TOKEN=$OPTARG;;
    u) URL=$OPTARG;;
  esac
done

COMMAND="${@: -1}"
CONTAINER_NAME="flowci-agent-$TOKEN"
RUNNING_CONTAINER=$(docker ps -aq -f name=$CONTAINER_NAME -f status=running)
EXISTED_CONTAINER=$(docker ps -aq -f name=$CONTAINER_NAME -f status=exited)

case $COMMAND in
	start) 
		checkUrlArg
		checkTokenArg
		start
		;;

	stop)
		checkTokenArg
		docker stop $CONTAINER_NAME
		;;

	clean)
		checkTokenArg
		docker rm -f $CONTAINER_NAME
		;;

	*)
		printHelp
		;;
esac