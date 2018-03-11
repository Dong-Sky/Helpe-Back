#!/usr/bin/env bash

source /etc/profile

# 免费账号需要激活账号和设置接受邮件地址

curl -iv -s --user 'api:key-2344f743806dc62499ec75eeb32d1134' \
    https://api.mailgun.net/v3/helpe.online/messages \
    -F from='Test Helpe Mail Service <service@helpe.online>' \
    -F to=ft20082@qq.com \
    -F subject='Hello' \
    -F text='Testing some Mailgun awesomeness!'



