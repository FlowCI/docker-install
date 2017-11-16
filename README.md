# 从 Docker 安装 flowci

## 安装 Docker 环境

> 具体的安装步骤请查看 [Docker 官方文档](https://docs.docker.com/)

## 从 Docker Hub 镜像启动

flowci 在 Docker Hub 上提供了最新的镜像，用户可以方便的获取最新的镜像并开始 flowci 之旅。

> 国内直接拉取 Docker Hub 会很慢, 加速请参考 [配置Docker Hub 加速器](https://www.docker-cn.com/registry-mirror), 或者自行配置阿里云等镜像

### 第一步 克隆本仓库

	仓库中提供了快速启动以及相关的服务器配置.
	

	- 通过 Git 的形式 Clone 代码，确保机器已经安装了 Git
	
	  `git clone git@github.com:FlowCI/docker.git`
	  
	- 直接通过 http 下载的形式下载代码，之后解压缩
	   
		`curl -L -o docker.zip https://github.com/FlowCI/docker/archive/master.zip`

### 第二步 从 Docker 启动 flowci

    进入到上一步获取的代码目录，并执行 `./start-services.sh`， 之后可以访问 `http://localhost:3000` 进入 flowci。
 
	
	> 环境变量的设置:
	> 
	> - `FLOW_API_DOMAIN`： 部署的后端 API 域名地址， 为 8080 端口， 默认：`127.0.0.1`
	> - `FLOW_WEB_DOMAIN`： 部署的前端 Web 页面的域名地址，为 3000 端口，默认：`127.0.0.1`
	> - `FLOW_SYS_EMAIL`：flowci 系统管理员账号，默认是 `admin@flow.ci `
	> - `FLOW_SYS_USERNAME`：flowci 系统管理员的用户名，默认是 `admin` 
	> - `FLOW_SYS_PASSWORD`: flowci 系统管理员密码，默认是 `123456`
	> - `MYSQL_PASSWORD`： flowci MYSQL 数据库 `root` 用户的密码，默认为 `flowci`

	例如：配置的域名为 `yourhost.com`，则可以通过以下命令启动:

	```bash
	FLOW_API_DOMAIN=yourhost.com FLOW_WEB_DOMAIN=yourhost.com ./start-services.sh
	```
	
## 从源代码构建 Docker 镜像并启动 (如果贡献或者修改了源码时会用到这种方式)

除了从 Docker Hub 直接获取 flowci 的镜像之外，用户也可以通过以下命令，从源代码直接构建 Docker 镜像，

> 镜像名称的设置: 
>  在修改镜像名称后，还需要修改 `docker-compose.yml` 中对应的镜像名称
> 
> - `DOCKER_NAME_FLOWCI`: flowci 后端 API 的 image 名称，默认 `flowci/flow.ci.backend` 
> - `DOCKER_NAME_FLOW_WEB`: flowci 前端 Web 的 image 名称，默认 `flowci/flow.web`
> - `DOCKER_NAME_FLOWCI_AGENT`: flowci Agent 的 image 名称，默认 `flowci/flow.ci.agent` 


```bash
mkdir flowci 
cd flowci 
git clone git@github.com:FlowCI/flow-platform.git 
git clone git@github.com:FlowCI/flow-web.git 
git clone git@github.com:FlowCI/docker.git 
cd docker 
./build-docker.sh
```

## 启动 Agent 

> 需要替换的环境变量:
> 
> - `FLOW_API_DOMAIN`： 为所配置的 API 的域，例如 `127.0.0.1`
> - `FLOW_TOKEN`:  Agent 启动令牌，如何获取请参见 [ Agent 管理 ](https://github.com/FlowCI/docs/blob/master/admin_agent.md)


- 以 Docker 方式启动
 
  `USER_DOCKER=true ./start-agent.sh $FLOW_API_DOMAIN $FLOW_TOKEN`

- Java 方式启动
  > 需要准备 Java 1.8 的环境
  
  `./start-agent.sh $FLOW_API_DOMAIN $FLOW_TOKEN`
  

