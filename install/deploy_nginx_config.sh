#!/usr/bin/env bash

cd `dirname $0`

# 放置配置文件
cp /data/backup/nginx_*.helpe.online.conf /etc/nginx/conf.d/

# 解压缩 ssl 文件


service nginx restart


