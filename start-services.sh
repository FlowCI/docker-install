#!/usr/bin/env bash

docker-compose up

docker run --network=host -e FLOW_ZOOKEEPER_HOST=127.0.0.1:2181 -e FLOW_BASE_URL=http://127.0.0.1:8080/flow-api -e FLOW_TOKEN=034d03c4-2756-4c1e-a0aa-85c7b196a16c flow.ci.agent:0.0.4