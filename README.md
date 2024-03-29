# Install from Docker within a minute | [1 分钟从 Docker 安装](./README_CN.md)

## Per-requirements

- [Docker](https://docs.docker.com/install/) installed
- [Docker-Compose](https://docs.docker.com/compose/install/) installed
- Mac/Linux/Windows
- Recommand 4 Cores, 8G RAM, and more than 60G free disk space

## Install

```bash
git clone https://github.com/FlowCI/docker-install.git flow-docker
cd flow-docker
./server.sh start

# ./server.sh help for more detail
```

After all services started, open web browser with url 'http://localhost:2015'

![start](https://github.com/FlowCI/docs/raw/master/_images/start_server.gif)

> The default ports and data path can be changed from [server.sh](./server.sh) and [server.yml](./server.yml)


# Install on Kubernetes by Helm Chart

```bash
helm repo add flow.ci https://flowci.github.io/helm-chart/
helm repo update

kubectl create ns flowci
helm install flow.ci flow.ci/flow.ci -n flowci
```