#!/bin/bash
set -e

# 等待 PostgreSQL 启动
until pg_isready -U $POSTGRES_USER; do
  sleep 1
done

# 修改 pg_hba.conf 允许远程连接
echo "host all all 0.0.0.0/0 md5" >>/var/lib/postgresql/data/pg_hba.conf

# 重新加载配置
psql -U $POSTGRES_USER -c "SELECT pg_reload_conf();"
