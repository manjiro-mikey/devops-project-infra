#!/bin/bash

# Turn off ufw on Ubuntu
sudo ufw disable

sudo hostnamectl set-hostname worker1

# hosts file
# Ansible -> edit
sudo tee /etc/hosts<<EOF
10.0.1.214 master
10.0.2.58 worker1
127.0.0.1 localhost
EOF

sudo apt update -y



# 2) Install kubelet, kubeadm and kubectl
# Once the servers are rebooted, add Kubernetes repository for Ubuntu 22.04 to all the servers.

sudo apt install curl apt-transport-https -y
# curl -fsSL  https://packages.cloud.google.com/apt/doc/apt-key.gpg|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/k8s.gpg
# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Then install required packages.
sudo apt update
sudo apt install wget curl vim git -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Confirm installation by checking the version of kubectl.
kubectl version --client && kubeadm version

# 3) Disable Swap Space
# Disable all swaps from /proc/swaps.
sudo swapoff -a
sudo sed -i '/swap/ s/^\(.*\)$/#\1/g' /etc/fstab

# Enable kernel modules and configure sysctl.

# Configure persistent loading of modules
sudo tee /etc/modules-load.d/k8s.conf <<EOF
overlay
br_netfilter
EOF

# Load at runtime
sudo modprobe overlay
sudo modprobe br_netfilter

# Ensure sysctl params are set
sudo tee /etc/sysctl.d/k8s.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload configs
sudo sysctl --system

# Install required packages
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

# Add Docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install containerd
sudo apt update
sudo apt install -y containerd.io

# Configure containerd and start service
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

# 5) Initialize control plane (run on first master node)
# Login to the server to be used as master and make sure that the br_netfilter module is loaded:

lsmod | grep br_netfilter

#Join with master 
# sudo kubeadm join 10.0.1.214:6443 --token 1t97iz.d4x2oxslg2t34bvt \
#         --discovery-token-ca-cert-hash sha256:1212bac9593ae9d1a96ef748e295cbec6f20e726228045ec20f84fee590e57ae