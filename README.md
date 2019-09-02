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

#### Command to start service:

```bash
## cd to docker dir which has been cloned
##
## example: cd ${HOME}/docker

./start-server.sh {host} {email} {password}
```

#### Arguments
- `{host}`: The host domain or ip address, find it by `ifconfig`.
    > Hint: It doesn't work for `127.0.0.1` or `localhost`
- `{email}` (Optional): Default admin email.
    > `admin@flow.ci` will be default value if this argument not defined.
- `{password}` (Optional): Default admin password. 
    > `123456` will be default value if this argument not dfined

#### Example

```bash
## Start with host, define admin email and password
./start-server.sh 172.20.10.4 admin@flow.ci 1qaz@WSX
```

## Start flow.ci Agent

- Create Agent
- 