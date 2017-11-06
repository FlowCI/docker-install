#!/usr/bin/env bash

echo "###########环境变量说明###########"
echo "FLOW_API: 部署的FlowApi地址, 默认是 http://localhost:8080/flow-api"

if [[ ! -n $FLOW_API ]]; then
	FLOW_API=http://localhost:8080/flow-api
fi

docker-compose up


