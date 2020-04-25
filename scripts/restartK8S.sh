#!/bin/bash

sudo swappoff --all

sudo systemctl restart kubelet
sudo systemctl status kubelet

echo "如果启动失败请重试"