部署
```
cd /opt/helpe_bak/Helpe-Back
git pull
php init
rsync -av --delete  /opt/helpe_bak/Helpe-Back/* /data/code/ --exclude "images" --exclude "runtime"
```