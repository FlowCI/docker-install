#!/usr/bin/env bash

echo "###########环境变量说明###########"

if [[ ! -n $FLOW_API_DOMAIN ]]; then
	echo "FLOW_API_DOMAIN: 部署的FlowApi地址, 默认是 http://localhost:8080"
	export FLOW_API_DOMAIN=http://localhost:8080
fi

if [[ ! -n $FLOW_WEB_DOMAIN ]]; then
	echo "FLOW_WEB_DOMAIN: 部署的FlowWeb地址, 默认是 http://localhost:3000"
	export FLOW_WEB_DOMAIN=http://localhost:3000
fi

if [[ ! -n $FLOW_WS_URL ]]; then
	echo "FLOW_WS_URL: FlowApi websocket 地址, 默认是 ws://localhost:8080"
	export FLOW_WS_URL=ws://localhost:8080
fi

if [[ ! -n $FLOW_ZOOKEEPER_URL ]]; then
	echo "FLOW_ZOOKEEPER_URL: ZooKeeper的地址， 默认是 127.0.0.1:2181"
	export FLOW_ZOOKEEPER_URL=127.0.0.1:2181
fi

if [[ ! -n $FLOW_SYS_EMAIL ]]; then
	echo "FLOW_SYS_EMAIL: Flow 的系统账号， 默认是 admin@flow.ci"
	export FLOW_SYS_EMAIL=admin@flow.ci
fi

if [[ ! -n $FLOW_SYS_USERNAME ]]; then
	echo "FLOW_SYS_USERNAME: Flow 的系统用户名， 默认是 admin"
	export FLOW_SYS_USERNAME=admin
fi

if [[ ! -n $FLOW_SYS_PASSWORD ]]; then
	echo "FLOW_SYS_PASSWORD: Flow 的系统密码， 默认是 123456"
	export FLOW_SYS_PASSWORD=123456
fi



docker-compose up


