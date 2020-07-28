# Install from Docker in 2 mins

## Per-requirements

- Mac or Linux (Windows not supported yet)

- [Docker](https://docs.docker.com/install/) installed

- [Docker-Compose](https://docs.docker.com/compose/install/) installed

## Getting Started

```bash
git clone https://github.com/FlowCI/docker-install.git flow-docker
cd flow-docker
./server.sh start

# ./server.sh help for more detail
```

![](https://github.com/FlowCI/docs/raw/master/src/start_server.gif)


After all services started, open web browser with url 'http://localhost:2015', adn type admin username (default: `admin@flow.ci`) and password (default: `example`) to login.

> The default ports are exposed to host and data path can be changed from [server.yml](./server.yml) and [start-server.sh](./server.sh)

