# zjuse-demo

## 仓库结构

```
zjuse-demo/
├── repo-group1-base/      基础信息组——教师信息查询服务
├── repo-group2-course/    排课组——排课服务
└── repo-infrastructure/   基建——Nginx 网关 + Docker Compose 合并部署
```

三个仓库通过 Git Submodule 引用，各仓库自身逻辑在各自README中详细介绍。

## 克隆

```bash
git clone --recurse-submodules git@github.com:uppi7/zjuse-demo.git
```

## 本地体验

**体验子系统独立开发（以 group1 为例）：**

```bash
cd repo-group1-base
cp .env.example .env
make dev
# http://localhost:5173
```

**体验大系统本地合并：**

```bash
cd repo-infrastructure
cp .env.example .env
# 在 .env 中设置 BUILD_MODE=local
./build-all.sh         
# 构建全部镜像 + 合并启动
```

---

## 拉取镜像组装

子组每次推送 `main` 分支，GitHub Actions 自动构建镜像并推送到 ghcr.io。大组直接拉取镜像组装运行：

```bash
git clone git@github.com:uppi7/repo-infrastructure.git
cd repo-infrastructure
cp .env.example .env
./build-all.sh
# http://localhost:8080/base/ 和 http://localhost:8080/course/
```
