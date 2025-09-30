# 内部开发工具链环境

这是一个用于在内部无互联网环境中运行开发工具链的Docker化解决方案，包含了代码开发平台、代码仓库、私有仓库管理、CI/CD服务等核心开发工具。

## 🚀 功能特性

- 代码开发平台: Coder - 基于Web的集成开发环境
- 代码仓库: Gitea - 轻量级自托管Git服务
- 私有仓库: Nexus - 组件管理和私有仓库
- CI/CD: Jenkins - 自动化构建和部署
- 容器编排: Docker Compose - 服务编排和管理
- 配置管理: 环境变量和Makefile简化操作

## 📋 前置要求

在开始之前，请确保您的系统已安装以下组件：

- Docker 20.10+
- Docker Compose 2.0+
- Make (可选，但推荐)

## 🛠 快速开始

### 1. 环境配置

复制环境配置文件并根据您的环境进行修改：

```shell
cp .env.example .env
```

编辑 `.env` 文件，设置必要的环境变量：

```shell
# 基本配置
COMPOSE_PROJECT_NAME=dev-toolchain
DOMAIN=internal.dev

# 服务端口配置
CODER_PORT=7080
GITEA_PORT=3000
NEXUS_PORT=8081
JENKINS_PORT=8080

# 其他配置...
```


### 2. 启动服务

使用以下命令启动所有服务：

```shell
# 使用 Makefile (推荐)
make up

# 或者直接使用 docker-compose
docker-compose up -d
```

### 3. 访问服务

服务启动后，可以通过以下地址访问：

| 服务 | 访问地址 | 默认端口 | 说明 |
| - | - | - | - |
| Coder | http://localhost:7080 | 7080 | 代码开发平台 |
| Gitea | http://localhost:3000 | 3000 | Git代码仓库 |
| Nexus | http://localhost:8081 | 8081 | 私有仓库管理 |
| Jenkins | http://localhost:8080 | 8080 | CI/CD服务 |

## 📁 项目结构

```
.
├── docker-compose.yaml    # 服务编排配置
├── Makefile              # 项目构建和管理命令
├── .env                  # 环境变量配置
├── data/                 # 数据持久化目录
│   ├── gitea/           # Gitea数据
│   ├── nexus/           # Nexus数据
│   ├── jenkins/         # Jenkins数据
│   └── coder/           # Coder数据
└── config/              # 服务配置文件
    ├── gitea/           # Gitea配置
    ├── nexus/           # Nexus配置
    └── jenkins/         # Jenkins配置
```

## 🔧 管理命令

使用`Makefile`

```shell
# 启动所有服务
make up

# 停止所有服务
make down

# 重启服务
make restart

# 查看服务状态
make status

# 查看服务日志
make logs

# 清理所有数据（谨慎使用）
make clean

# 备份数据
make backup
```


直接使用 `Docker Compose`

```shell
# 启动服务
docker-compose up -d

# 停止服务
docker-compose down

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f
```

## ⚙️ 服务配置

### Coder 配置

- 默认访问端口: 7080
- 数据目录: ./data/coder
- 配置说明: 基于Web的云端开发环境

### Gitea 配置

- 默认访问端口: 3000
- 数据目录: ./data/gitea
- 首次访问需要完成初始化设置

### Nexus 配置

- 默认访问端口: 8081
- 数据目录: ./data/nexus
- 默认管理员账号: admin
- 默认密码: 查看容器日志获取初始密码

### Jenkins 配置

- 默认访问端口: 8080
- 数据目录: ./data/jenkins
- 首次访问需要解锁，按照页面提示操作

## 🔒 安全说明

1. 初始密码: 首次启动后请立即修改各服务的默认密码

2. 网络隔离: 确保服务仅在内部网络可访问

3. 数据备份: 定期备份 data 目录中的重要数据

4. 版本更新: 定期更新服务版本以修复安全漏洞

## 🗂 数据持久化

所有服务的数据都通过Docker卷进行持久化存储：

- 应用数据: 存储在 ./data 目录
- 数据库: 使用卷持久化
- 配置文件: 存储在 ./config 目录

## 🚨 故障排除

### 常见问题

#### 1. 端口冲突

- 修改 `.env` 文件中的端口配置
- 确保端口未被其他应用占用

#### 2. 权限问题

- 确保当前用户有权限访问Docker
- 检查数据目录的读写权限

#### 3. 服务启动失败

- 检查系统资源（内存、磁盘空间）
- 查看具体服务的日志：docker-compose logs [service-name]

### 日志查看

```shell
# 查看所有服务日志
make logs

# 查看特定服务日志
docker-compose logs -f gitea
```


## 📈 未来规划

- 集成 Harbor 镜像仓库
- 集成 Jira 项目管理平台
- 添加监控和告警功能
- 支持高可用部署
- 添加备份和恢复脚本

## 🤝 贡献指南

欢迎提交Issue和Pull Request来帮助改进这个项目。

## 📄 许可证

本项目基于MIT许可证，详见LICENSE文件。

## 📞 支持

如果在使用过程中遇到问题，请：

1. 查看本文档的故障排除部分
1. 检查GitHub Issues中是否有类似问题
1. 创建新的Issue并描述详细的问题和复现步骤

注意: 此环境设计用于内部无互联网环境，请确保所有服务配置符合您组织的安全策略。

*本回答由 AI 生成，内容仅供参考，请仔细甄别。*
