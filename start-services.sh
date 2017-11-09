#!/usr/bin/env bash

echo "###########环境变量说明###########"

if [[ ! -n $FLOW_API_DOMAIN ]]; then
	export FLOW_API_DOMAIN=http://localhost:8080
fi
echo "FLOW_API_DOMAIN: 部署的FlowApi地址, 默认是 http://localhost:8080, 当前参数值是 ${FLOW_API_DOMAIN}"

if [[ ! -n $FLOW_WEB_DOMAIN ]]; then
	export FLOW_WEB_DOMAIN=http://localhost:3000
fi
echo "FLOW_WEB_DOMAIN: 部署的FlowWeb地址, 默认是 http://localhost:3000, 当前参数值是 $FLOW_WEB_DOMAIN"

if [[ ! -n $FLOW_WS_URL ]]; then
	export FLOW_WS_URL=ws://localhost:8080
fi
echo "FLOW_WS_URL: FlowApi websocket 地址, 默认是 ws://localhost:8080, 当前参数值是 $FLOW_WS_URL"

if [[ ! -n $FLOW_ZOOKEEPER_URL ]]; then
	export FLOW_ZOOKEEPER_URL=127.0.0.1:2181
fi
echo "FLOW_ZOOKEEPER_URL: ZooKeeper的地址， 默认是 127.0.0.1:2181, 当前参数值是 $FLOW_ZOOKEEPER_URL"

if [[ ! -n $FLOW_SYS_EMAIL ]]; then
	export FLOW_SYS_EMAIL=admin@flow.ci
fi
echo "FLOW_SYS_EMAIL: Flow 的系统账号， 默认是 admin@flow.ci, 当前参数值是 $FLOW_SYS_EMAIL"

if [[ ! -n $FLOW_SYS_USERNAME ]]; then
	export FLOW_SYS_USERNAME=admin
fi
echo "FLOW_SYS_USERNAME: Flow 的系统用户名， 默认是 admin, 当前参数值是 $FLOW_SYS_USERNAME"

if [[ ! -n $FLOW_SYS_PASSWORD ]]; then
	export FLOW_SYS_PASSWORD=123456
fi
echo "FLOW_SYS_PASSWORD: Flow 的系统密码， 默认是 123456, 当前参数值是 $FLOW_SYS_PASSWORD"



docker-compose up


