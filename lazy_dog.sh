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
# 下載 ZBX-office-dockerfile 並安裝 ZBX_4.0
  git clone https://github.com/zabbix/zabbix-docker.git -b 4.0
# ZBX_5.4 
# git clone https://github.com/zabbix/zabbix-docker.git -b 5.4
  cd zabbix-docker 
  docker-compose -f docker-compose_v3_centos_mysql_latest.yaml up -d
# 睡 30 秒後，測試 80
  sleep 10
  echo " 經過 10 s"
  sleep 10
  echo " 經過 20 s"
  sleep 10 
  echo " 經過 20 s" 
  curl http://127.0.0.1
  echo " 倘若無法於 localhost　測試成功，請參考下列出資訊 "
# 查看 docker ps 
  echo "################"
  echo " 檢測 docker ps " 
  echo "################"
  echo " "
  echo " 倘若 docker ps 正常，請稍後幾分鐘等候 docker 延遲等情況 " 
