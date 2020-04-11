#!/bin/bash
# 卸载k8s
kubeadm reset -f
sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*    -y
sudo apt-get autoremove   -y
sudo rm -rf ~/.kube

# 删除垃圾文件
sudo rm -rf ~/.kube/
sudo rm -rf /etc/kubernetes/
sudo rm -rf /etc/systemd/system/kubelet.service.d
sudo rm -rf /etc/systemd/system/kubelet.service
sudo rm -rf /usr/bin/kube*
sudo rm -rf /etc/cni
sudo rm -rf /opt/cni
sudo rm -rf /var/lib/etcd
