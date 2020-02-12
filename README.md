# Install from Docker within 5 mins

## Per-requirements

- Mac or Linux (Windows not supported yet)

- [Docker](https://docs.docker.com/install/) installed

- [Docker-Compose](https://docs.docker.com/compose/install/) installed

- Clone this 'docker' repo (make sure the scripts and docker compose file are available)

    ```bash
    git clone https://github.com/FlowCI/docker.git
    ```

## Start Service

```bash
./server.sh start

# Usage: ./server.sh [OPTIONS] COMMAND

# Example: ./server.sh -h 172.20.2.1 -e admin@flow.ci -p yourpassword start

# Options:
#  -h	 Host ip address
#  -e	 Default admin email
#  -p	 Default admin password

# Commands:
#  start	 start ci server
#  stop	 stop ci server
#  clean	 remove ci server containers
#  help	 print help message

```

![](https://github.com/FlowCI/docs/raw/master/v1.0/img/start_server.gif)


 Default Settings

- Port `8080`: core service
- Port `2015`: web
- Port `27017`: database
- Port `2181`: zookeeper
- Port `5672` & `15672`: rabbitmq
- Port `9000`: minio
- where to store the data: `${HOME}/.flow.ci`

> The default ports are exposed to host and data path can be changed from [server.yml](./server.yml) and [start-server.sh](./start-server.sh)


## Start Agent

![](https://github.com/FlowCI/docs/raw/master/v1.0/img/start_agent.gif)

### 1. Create Agent from admin page

- Open web page: `http://{host}:2015/#/settings/agents` and click add
  ![](https://github.com/FlowCI/docs/raw/master/v1.0/img/agent_add_click.png)
- Fill in agent name.
- Fill in agent tag and click '+' button to add.
- Click 'save' button
  ![](https://github.com/FlowCI/docs/raw/master/v1.0/img/agent_save_new.png)

### 2. Start from command

- Click 'copy' button to copy the token
  ![](https://github.com/FlowCI/docs/raw/master/v1.0/img/agent_copy_token.png)

- Start from command: `start-agent.sh {host} {token}`
  - `{host}`: the host or ip address of server
  - `{token}`: the agent token copied from admin page
  - example:

  ```bash
  ./start-agent.sh 172.20.10.4 c2a957b7-5d09-4aa8-8d4f-90a0c2ee1392
  ```

Default Settings

- Port: the default port for ci server is `8080`
- Where to store the data: default path is `${HOME}/.flow.ci.agent`

> those settings could be changed from [start-agent.sh](./start-agent.sh)

### 3. Per-installed envrionments

- git: `2.17.1`
- java: openjdk `1.8.0_222`
- mvn: `3.5.4`
- nvm: `0.34.0`
- node: `v10.16.3`
- go: `1.12.9`
