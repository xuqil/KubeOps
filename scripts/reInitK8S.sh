#!/bin/bash

sudo kubeadm reset -f

ehco   "******************************初始化******************************"
sudo kubeadm init --kubernetes-version=1.16.0 --apiserver-advertise-address=0.0.0.0 --image-repository registry.aliyuncs.com/google_containers --service-cidr=10.1.0.0/16 --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# shellcheck disable=SC2046
sudo chown $(id -u):$(id -g) $HOME/.kube/config


kubectl apply -f calico.yaml

# 单节点集群，取消master的污点标记
kubectl taint nodes --all node-role.kubernetes.io/master-