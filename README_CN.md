# 1 分钟从 Docker 安装

## 基础环境

- 需要 [Docker](https://docs.docker.com/install/)
- 需要 [Docker-Compose](https://docs.docker.com/compose/install/)
- Mac/Linux/Windows
- 建议 4核 CPU， 8G 内存，60G 以上存储空间

## 安装

运行如下命令:

```bash
git clone https://github.com/FlowCI/docker-install.git flow-docker
cd flow-docker
./server.sh start

# ./server.sh help 获得更多信息
```

当服务启动后, 可以打开浏览器访问 'http://localhost:2015'

![start](https://github.com/FlowCI/docs/raw/master/src/start_server.gif)

> 默认的端口，和数据路径可以从 [server.sh](./server.sh) 和 [server.yml](./server.yml) 中修改
