#!/bin/bash

adoptium(){
  sudo apt update
  sudo apt install -y wget apt-transport-https gnupg

  adoptGpg=/etc/apt/trusted.gpg.d/adoptium.gpg
  wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo gpg --dearmor -o $adoptGpg

  CODEBASE=$(lsb_release -cs)
  if [ -f "/etc/upstream-release/lsb-release" ]; then #it's a Linux Mint...
    CODEBASE=$(grep DISTRIB_CODENAME= /etc/upstream-release/lsb-release | cut -d'=' -f2)
  fi

  echo "deb [signedBy=${adoptGpg}] https://packages.adoptium.net/artifactory/deb ${CODEBASE} main" | sudo tee /etc/apt/sources.list.d/adoptium.list
}

jvm=temurin-21-jdk
if ! [ -d "/usr/lib/jvm/${jvm}-amd64" ]; then
  adoptium
  sudo apt update
  sudo apt install -y ${jvm}
fi
