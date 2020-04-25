#!/bin/bash
# 前提:安装了docker
echo '******************************配置***********************************'

# 禁掉所有的swap分区
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# 开启ip_vs
# shellcheck disable=SC2024
sudo cat > /etc/rc.local << EOF
#! /bin/bash

sudo modprobe -- ip_vs
sudo modprobe -- ip_vs_rr
sudo modprobe -- ip_vs_wrr
sudo modprobe -- ip_vs_sh
sudo modprobe -- br_netfilter
exit 0

EOF

sudo apt-get install ipset ipvsadm -y


# 开启ipforward

# shellcheck disable=SC2024
sudo cat > /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
vm.swappiness = 0
net.ipv4.conf.all.rp_filter=1
EOF

sudo modprobe br_netfilter
sudo sysctl -p /etc/sysctl.d/k8s.conf

echo "******************************安装***********************************"

# 添加kubernetes源，安装kubeadm工具

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
sudo curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -

sudo tee /etc/apt/sources.list.d/kubernetes.list <<-'EOF'
deb https://mirrors.aliyun.com/kubernetes/apt kubernetes-xenial main
EOF

sudo apt-get update -y

echo "******************************安装kubeadm、kubelet、kubectl******************************"
sudo apt-get install kubeadm=1.16.0-00 kubelet=1.16.0-00 kubectl=1.16.0-00 -y

ehco   "******************************初始化******************************"
sudo kubeadm init --kubernetes-version=1.16.0 --apiserver-advertise-address=0.0.0.0 --image-repository registry.aliyuncs.com/google_containers --service-cidr=10.1.0.0/16 --pod-network-cidr=10.244.0.0/16

mkdir -p "$HOME"/.kube
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
# shellcheck disable=SC2046
sudo chown $(id -u):$(id -g) "$HOME"/.kube/config

sudo systemctl enable kubelet

echo "******************************安装calico网络插件******************************"


kubectl apply -f calico.yaml

# 单节点集群，取消master的污点标记
kubectl taint nodes --all node-role.kubernetes.io/master-

echo "*****************************ok*****************************"
