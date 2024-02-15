#!/bin/bash

#https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce-1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

dockerPkg(){
  sudo apt install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common

  dockerGpg=/etc/apt/trusted.gpg.d/docker.gpg
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o $dockerGpg

  CODEBASE=$(lsb_release -cs)
  if [ -f "/etc/upstream-release/lsb-release" ]; then #it's a Linux Mint...
    CODEBASE=$(grep DISTRIB_CODENAME= /etc/upstream-release/lsb-release | cut -d'=' -f2)
  fi
  sudo add-apt-repository \
    "deb [arch=amd64 signedBy=${dockerGpg}] https://download.docker.com/linux/ubuntu \
    ${CODEBASE} \
    stable"
}

dockerInst(){
  sudo apt update
  sudo apt install -y docker-ce
  sudo apt install -y docker-compose

  dockerBlob="/mnt/data/blob/docker" 
  if [ -d "/mnt/data/blob/docker" ]; then
    # copy my customizations (e.g. other images dir)
    sudo cp -v ${DIR}/docker-daemon.json.template /etc/docker/daemon.json
  else
    echo "==> SKIPPING, docker images dir customization, due to missing ${dockerBlob}"
  fi

  # Add current user to docker group
  sudo usermod -aG docker "$USER"
}

dockerPkg
dockerInst
