#!/bin/bash

#  删除docker,及其安装时自动安装的所有包
sudo apt-get autoremove docker docker-ce docker-engine  docker.io  containerd runc  -y
dpkg -l | grep docker
sudo apt-get autoremove docker-ce-* -y

 sudo rm -rf /etc/systemd/system/docker.service.d
 sudo rm -rf /var/lib/docker

