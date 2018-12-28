#!/bin/bash

#https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce-1

sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#other version than bionic???
sudo `deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable >> /etc/apt/sources-list`

sudo apt update
sudo apt install -y docker-ce
sudo apt install -y docker-compose

# copy my customizations (e.g. other images dir)
sudo cp -v docker-daemon.json.template /etc/docker/daemon.json
