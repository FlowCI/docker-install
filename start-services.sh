#!/usr/bin/env bash

# Pull and run required services via docker

# pull mysql docker image
# docker pull mysql:5.6

# pull rabbitmq 3.6.10 docker image
# docker pull rabbitmq:3.6

#docker run -d -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -p 3306:3306 mysql:5.6
#docker run -d -p 8080:8080 flow.ci.backend

docker-compose up

docker run --network=host -e FLOW_ZOOKEEPER_HOST=127.0.0.1:2181 -e FLOW_BASE_URL=http://127.0.0.1:8080/flow-api -e FLOW_TOKEN=4168a50d-23f2-46e8-afa7-d2e645d9f430 flow.ci.agent