#!/usr/bin/env bash

## The script used to start flow.ci server from docker-compose ##

printHelp() 
{
	echo ""
   	echo "Usage: $0 [OPTIONS] COMMAND"

	echo ""
	echo "Example: ./server.sh -h 172.20.2.1 start"

	echo ""
	echo "Options:"
	echo -e " -h\t Host ip address"

	echo ""
	echo "Commands:"
	echo -e " start\t start ci server"
	echo -e " stop\t stop ci server"
	echo -e " down\t remove ci server containers"
	echo -e " help\t print help message"
	
   	exit 1 # Exit script after printing help
}

initEnv() 
{
	## $HOST is the ip address of host, it can be gained from setDefaultValue func automatically
	export FLOWCI_SERVER_HOST=$HOST

	## setup ports
	export FLOWCI_WEB_PORT=2015
	export FLOWCI_SERVER_PORT=8080
	export FLOWCI_SERVER_URL="http://$FLOWCI_SERVER_HOST:$FLOWCI_SERVER_PORT"

	## setup minio keys
	export FLOWCI_DEFAULT_MINIO_ACCESS_KEY=minio
	export FLOWCI_DEFAULT_MINIO_SECRET_KEY=minio123

	## setup agnet volumes for local auto agent
	export FLOWCI_AGENT_VOLUMES="name=pyenv,dest=/ci/python,script=init.sh,image=flowci/pyenv:1.3,init=init-pyenv-volume.sh"

	## setup data path
	export FLOWCI_DATABASE_DIR="$HOME/.flowci/db"
	export FLOWCI_WORKSPACE_DIR="$HOME/.flowci/ws"
	export FLOWCI_DATA_DIR="$HOME/.flowci/data"

	mkdir -p $FLOWCI_DATABASE_DIR
	mkdir -p $FLOWCI_WORKSPACE_DIR
	mkdir -p $FLOWCI_DATA_DIR
}

printInfo()
{
	echo ""
	echo "[INFO] Server URL:	$FLOWCI_SERVER_URL"

	echo ""
	echo -e "\xF0\x9f\x8d\xba  HOW TO:"
	echo -e "\xF0\x9F\x91\x89   Open Web UI:\t http://$FLOWCI_SERVER_HOST:$FLOWCI_WEB_PORT"
	echo -e "\xF0\x9F\x91\x89   Start Agent:\t ./agent.sh -u $FLOWCI_SERVER_URL -t your_agent_token start"
	echo ""
}

setDefaultValue()
{
	if [[ ! -n $HOST ]]; then
		if [[ $OSTYPE == "darwin"* ]]; then
			HOST=$(ipconfig getifaddr en0)
			echo "[WARN]: Host ip not defined, using ip $HOST"
		
		elif [[ $OSTYPE == "linux"* ]]; then
			interface=$(awk '$2 == 00000000 { print $1 }' /proc/net/route| head -1)
			HOST=$(ip addr show ${interface} 2>/dev/null| grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
			echo "[WARN]: Host ip not defined, using ip $HOST"

		else 
			echo "[WARN]: Host ip addr cannot detected, please specify ip or host name by -h your_ip_or_host_name"
			exit 1
		fi
	fi
}

pullAgentImage()
{
	img=$(docker images flowci/agent:latest --format "{{.ID}}")
	if [[ ! -n $img ]]; then
		echo "[INFO] Pull agent docker image.."
		docker pull flowci/agent:latest
	fi
}

while getopts ":h:" arg; do
  case $arg in
    h) HOST=$OPTARG;;
  esac
done

COMMAND="${@: -1}"

case $COMMAND in
	start)
		pullAgentImage
		setDefaultValue
		initEnv
		printInfo
		docker-compose -f server.yml up -d
		;;

	stop)
		initEnv
		docker-compose -f server.yml stop
		;;

	down)
		initEnv
		docker-compose -f server.yml down
		;;

	*)
		printHelp
		;;
esac
