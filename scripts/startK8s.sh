#!/bin/bash


for i in `docker container ls -a | grep k8s | awk '{print $1}'`;
do
  sudo docker start $i
done

echo "如果启动失败请重试"