# Getting Started

## Per-requirements

- [docker](https://docs.docker.com/install/)

- [docker-compose](https://docs.docker.com/compose/install/)

- Clone 'docker' repo

    To make sure the script and docker compose file can be found

    ```bash
    git clone https://github.com/FlowCI/docker.git
    ```

## Start flow.ci Service

### Command to start service

```bash
## cd to docker dir which has been cloned
##
## example: cd ${HOME}/docker

./start-server.sh {host} {email} {password}
```

### Arguments

- `{host}`: The host domain or ip address, find it by `ifconfig`.
    > Hint: It doesn't work for `127.0.0.1` or `localhost`
- `{email}` (Optional): Default admin email.
    > `admin@flow.ci` will be default value if this argument not defined.
- `{password}` (Optional): Default admin password. 
    > `123456` will be default value if this argument not dfined

### Default ports

- `8080`: core service
- `2015`: web
- `27017`: database
- `2181`: zookeeper
- `5672` & `15672`: rabbitmq

> The ports are exposed to host can be changed from `server.yml`

### Example

```bash
## Start with host, define admin email and password
./start-server.sh 172.20.10.4 admin@flow.ci 1qaz@WSX
```

### Test It

Login with admin email and password on `http://{host}:2015`

![](https://github.com/flowci/files/raw/master/imgs/start_server.gif)


## Start flow.ci Agent

- Per-install envrionments
  - git: `2.17.1`
  - java: openjdk `1.8.0_222`
  - mvn: `3.5.4`
  - nvm: `0.34.0`
  - node: `v10.16.3`
  - go: `1.12.9`

- Create Agent from admin page
  - Open web page: `http://{host}:2015/#/settings/agents` and click add
    ![](https://github.com/flowci/files/raw/master/imgs/agent_add_click.png)
  - Fill in agent name.
  - Fill in agent tag and click '+' button to add.
  - Click 'save' button
    ![](https://github.com/flowci/files/raw/master/imgs/agent_save_new.png)

- Start
  - Click 'copy' button to copy the token
    
    ![](.https://github.com/flowci/files/raw/master/imgs/agent_copy_token.png)

  - Start from command: `start-agent.sh {host} {token}`
    - `{host}`: the host or ip address of server
    - `{token}`: the agent token copied from admin page
    - example:

    ```bash
    ./start-agent.sh 172.20.10.4 c2a957b7-5d09-4aa8-8d4f-90a0c2ee1392
    ```
  