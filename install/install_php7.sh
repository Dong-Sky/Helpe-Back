#!/usr/bin/env

sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

sudo yum install yum-utils

sudo yum-config-manager --enable remi-php72

sudo yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo php-fpm




