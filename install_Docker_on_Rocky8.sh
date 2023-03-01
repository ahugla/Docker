#!/bin/bash

# install Docker on Rocky Linux
# ----------------------------- 
#https://www.golinuxcloud.com/install-rancher-rocky-linux-9/


cd /tmp

# Update PATH
export PATH=$PATH:/usr/local/sbin:/usr/sbin:/root/bin

# Disable SELinux
setenforce 0
sed -i '/^SELINUX./ { s/enforcing/disabled/; }' /etc/selinux/config

# Disable memory swapping
swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Enable bridged networking and set iptables
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

# on desinstalle les precedentes versions
dnf -y remove docker docker-common docker-selinux docker-engine

dnf update -y

dnf -y install device-mapper-persistent-data lvm2

dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin --allowerasing

systemctl enable docker --now
#systemctl status docker
docker --version
