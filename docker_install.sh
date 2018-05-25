#!/bin/bash



yum install -y yum-utils device-mapper-persistent-data lvm2


yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-edge
yum-config-manager --enable docker-ce-test


yum install -y docker-ce    # latest version

systemctl start docker

systemctl enable docker




# Remote API
initialchaine="ExecStart=\/usr\/bin\/dockerd"
newchaine="ExecStart=\/usr\/bin\/dockerd  -H unix:\/\/\/var\/run\/docker.sock  -H tcp:\/\/0.0.0.0:2375"
sed -i -e 's/'"$initialchaine"'/'"$newchaine"'/g'  /usr/lib/systemd/system/docker.service




systemctl stop docker

systemctl daemon-reload

systemctl start docker

