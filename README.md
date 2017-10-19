# docker

### Build by docker

Run `./build-docker.sh` will generate required docker images `flow.ci.backend` for back-end and `flow.ci.agent` for agent.

**To start flow.ci backend services**

`docker-compose up`

**To start flow.ci agent** 

`docker run --network=host -e FLOW_ZOOKEEPER_HOST=127.0.0.1:2181 -e FLOW_AGENT_ZONE=default -e FLOW_AGENT_NAME={agent name you want} flow.ci.agent`

