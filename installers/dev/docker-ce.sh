#!/bin/bash

#https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce-1

sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

CODEBASE=$(lsb_release -cs)
if [ -f "/etc/upstream-release/lsb-release" ]; then #it's a Linux Mint...
  CODEBASE=$(grep DISTRIB_CODENAME= /etc/upstream-release/lsb-release | cut -d'=' -f2)
fi
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   ${CODEBASE} \
   stable"

sudo apt update
sudo apt install -y docker-ce
sudo apt install -y docker-compose

# copy my customizations (e.g. other images dir)
sudo cp -v docker-daemon.json.template /etc/docker/daemon.json

# Add current user to docker group
sudo usermod -aG docker "$USER"
