#!/usr/bin/env bash


cat >> /etc/yum.repos.d/nginx.repo <<EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/\$basearch/
gpgcheck=0
enabled=1
EOF


yum update

yum install nginx

service nginx start

chkconfig --level 2345 nginx on