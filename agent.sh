#!/usr/bin/env bash

## The script used to start flow.ci agent from docker ##

printHelp() 
{
	echo ""
   	echo "Usage: $0 [OPTIONS] COMMAND"

	echo ""
	echo "Example: ./agent.sh -t token_from_ci_server -u http://172.20.10.4:8080 start"

	echo ""
	echo "Options:"
	echo -e " -t\t Agent token from ci server"
   	echo -e " -u\t Server url"
	echo -e " -m\t Start agent by docker or binary"

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

startAgent()
{
	# setup pyenv for docker runtime in step
	docker volume create pyenv
	docker run --rm -v pyenv:/target flowci/pyenv:1.3 bash -c "/ws/init-pyenv-volume.sh"

	echo $URL
	echo $TOKEN
	echo $MODEL

	if [[ $MODEL == "docker" ]]; then
		startFromDocker
	elif [[ $MODEL == "binary" ]]; then
		startFromBinary
	else
		echo "[WARN] Agent start model not defined, using default docker agent"
		startFromDocker
	fi
}

startFromBinary()
{
	mkdir -p ./bin
	target_bin=./bin/flow-agent-x

	if [[ ! -f $target_bin ]]; then
		if [[ $OSTYPE == "darwin"* ]]; then
			curl -L -o $target_bin https://github.com/FlowCI/flow-agent-x/releases/download/v$AGENT_VERSION/flow-agent-x-mac
		
		elif [[ $OSTYPE == "linux"* ]]; then
			curl -L -o $target_bin https://github.com/FlowCI/flow-agent-x/releases/download/v$AGENT_VERSION/flow-agent-x-linux

		else 
			echo "[WARN]: Agent not supported for os $OSTYPE"
			exit 1
		fi
	fi

	chmod +x $target_bin
	
	AGENT_HOST_DIR=$HOME/.agent.$TOKEN
	mkdir -p $AGENT_HOST_DIR

	echo "Starting agent from binary"
	$target_bin -u $URL -t $TOKEN -w $AGENT_HOST_DIR -m "name=pyenv,dest=/ci/python,script=init.sh"
}

startFromDocker()
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
		-e FLOWCI_AGENT_VOLUMES="name=pyenv,dest=/ci/python,script=init.sh" \
		-e FLOWCI_AGENT_WORKSPACE="/ws" \
		-v $AGENT_HOST_DIR:/ws \
		-v pyenv:/ci/python \
		-v /var/run/docker.sock:/var/run/docker.sock \
		flowci/agent:$AGENT_VERSION
	fi
}

while getopts ":u:t:m:" arg; do
  case $arg in
    u) URL=$OPTARG;;
    t) TOKEN=$OPTARG;;
	m) MODEL=$OPTARG;;
  esac
done

AGENT_VERSION=0.20.32
COMMAND="${@: -1}"
CONTAINER_NAME="flowci-agent-$TOKEN"
RUNNING_CONTAINER=$(docker ps -aq -f name=$CONTAINER_NAME -f status=running)
EXISTED_CONTAINER=$(docker ps -aq -f name=$CONTAINER_NAME -f status=exited)

case $COMMAND in
	start) 
		checkUrlArg
		checkTokenArg
		startAgent
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
