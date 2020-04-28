#!/bin/bash
echo "初始化该用户的K8S"

mkdir -p "$HOME"/.kube
sudo cp -f /etc/kubernetes/admin.conf "$HOME"/.kube/config
# shellcheck disable=SC2046
sudo chown $(id -u):$(id -g) "$HOME"/.kube/config