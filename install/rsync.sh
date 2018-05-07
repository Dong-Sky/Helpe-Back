#!/usr/bin/env bash



rsync -av --delete  /opt/helpe_bak/Helpe-Back/* /data/code/ --exclude "images" --exclude "runtime"


