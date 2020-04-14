#!/bin/bash

#卸载旧docker
sudo apt-get remove docker \
               docker-engine \
               docker.io

sudo apt-get update -y
#安装依赖
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y

#添加源
curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

#自动化安装
sudo apt-get update -y
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun

#添加组
sudo groupadd docker
sudo usermod -aG docker $USER