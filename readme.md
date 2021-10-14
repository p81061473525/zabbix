# 這是一個 zabbix 安裝 與 操作專案

(time1) [root@as-50-200 ~]# getenforce
Disabled

# lazydog.sh 

```
#!/bin/bash
 set -e
 set -x 

# 關閉 selinux
  setenforce 0 

# yum 安裝 docker 
  yum install docker -y 
# systemd 默認並啟動 docker-engine
  systemctl enable docker --now 
# 安裝 docker-compose 
  curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
  chmod +x /usr/local/bin/docker-compose
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  echo " 較驗 docker-compose 安裝 : "
  docker-compose -v 
# 下載 ZBX-office-dockerfile 並安裝 ZBX_5.4
  git clone https://github.com/zabbix/zabbix-docker.git
  cd zabbix-docker 
  git checkout -b 4.0
  docker-compose -f docker-compose_v3_centos_mysql_latest.yaml up -d
# 睡 30 秒後，測試 80
  sleep 30
  curl http://127.0.0.1 
