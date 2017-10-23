#!/usr/bin/env bash

docker run --network=host -e FLOW_ZOOKEEPER_HOST=127.0.0.1:2181 -e FLOW_BASE_URL=$1 -e FLOW_TOKEN=$2 flow.ci.agent