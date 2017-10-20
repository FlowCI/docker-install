#!/usr/bin/env bash

docker-compose up

docker run --network=host -e FLOW_ZOOKEEPER_HOST=127.0.0.1:2181 -e FLOW_BASE_URL=http://127.0.0.1:8080/flow-api -e FLOW_TOKEN=4168a50d-23f2-46e8-afa7-d2e645d9f430 flow.ci.agent