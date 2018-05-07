#!/usr/bin/env bash

yum install mariadb-devel mariadb-embedded mariadb-embedded-devel mariadb-libs mariadb-server mariadb


service mariadb start

chkconfig  --level 2345 mariadb on

