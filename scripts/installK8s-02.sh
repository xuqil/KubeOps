#!/bin/bash
# 前提:执行了installK8s-02.sh
echo '******************************使用普通用户执行***********************************'
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

mkdir -p $HOME/.kube
 sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
 sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "******************************安装calico网络插件******************************"

 #不需要这个步骤
POD_CIDR=`ip a | grep inet | grep wlp1s0 | awk '{print $2}' | awk -F '/' '{print $1}'`  sed -i -e "s?192.168.0.0/16?$POD_CIDR?g" calico.yaml 

kubectl apply -f calico.yaml

# 单节点集群，取消master的污点标记
kubectl taint nodes --all node-role.kubernetes.io/master-