#!/bin/bash
# 前提:安装了docker
# 使用ROOT用户执行
echo '******************************使用root执行***********************************'
echo '******************************配置***********************************'

# 禁掉所有的swap分区
sudo swapoff -a

# 开启ip_vs
cat > /etc/rc.local << EOF
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

cat > /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
vm.swappiness = 0
net.ipv4.conf.all.rp_filter=1
EOF

modprobe br_netfilter
sysctl -p /etc/sysctl.d/k8s.conf

echo "*****************************ok*****************************"