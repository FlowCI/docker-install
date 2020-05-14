# Install from Docker in 2 mins

## Per-requirements

- Mac or Linux (Windows not supported yet)

- [Docker](https://docs.docker.com/install/) installed

- [Docker-Compose](https://docs.docker.com/compose/install/) installed

- Clone this 'docker' repo (make sure the scripts and docker compose file are available)

    ```bash
    git clone https://github.com/FlowCI/docker-install.git
    ```

## Start Service

```bash
./server.sh start

# ./server.sh help for more detail
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

> The default ports are exposed to host and data path can be changed from [server.yml](./server.yml) and [start-server.sh](./server.sh)

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

Click 'copy' button to copy the token
![](https://github.com/FlowCI/docs/raw/master/v1.0/img/agent_copy_token.png)


Run script `./agent.sh`

```bash
./agent.sh -u ci_server -t token_your_copied start
```
