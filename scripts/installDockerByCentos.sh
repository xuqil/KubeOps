#!/bin/bash

#卸载旧版本
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine -y


#安装依赖
sudo yum install -y yum-utils \
           device-mapper-persistent-data \
           lvm2 -y


#添加yum源
sudo yum-config-manager \
  --add-repo \
  https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
sudo sed -i 's/download.docker.com/mirrors.ustc.edu.cn\/docker-ce/g' /etc/yum.repos.d/docker-ce.repo

#手动安装
#sudo yum makecache fast
#sudo yum install docker-ce

#or自动化安装
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun

#启动
sudo systemctl enable docker
sudo systemctl start docker

#添加组
sudo groupadd docker
sudo usermod -aG docker $USER


#添加内核参数
sudo tee -a /etc/sysctl.conf <<-EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl -p