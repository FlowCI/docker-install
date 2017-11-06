#!/usr/bin/env bash

echo "###########环境变量说明###########"
echo "FLOW_API_DOMAIN: 部署的FlowApi地址, 默认是 http://localhost:8080"
echo "FLOW_WEB_DOMAIN: 部署的FlowWeb地址, 默认是 http://localhost:80"
echo "FLOW_WS_URL: FlowApi websocket 地址, 默认是 ws://localhost:8080"

if [[ ! -n $FLOW_API_DOMAIN ]]; then
	export FLOW_API_DOMAIN=http://localhost:8080
fi

if [[ ! -n $FLOW_WEB_DOMAIN ]]; then
	export FLOW_WEB_DOMAIN=http://localhost:80
fi

if [[ ! -n $FLOW_WS_URL ]]; then
	export FLOW_WS_URL=ws://localhost:8080
fi

docker-compose up


