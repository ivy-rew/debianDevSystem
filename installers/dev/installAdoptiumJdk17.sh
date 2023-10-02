#!/bin/bash

if ! [ -d "/usr/lib/jvm/temurin-17-jdk-amd64" ]; then
  sudo apt update
  sudo apt install -y wget apt-transport-https gnupg

  # Install OpenJDK 17 of Temurin (fixes AWT/Swing integration library load bugs)
  adoptGpg=/etc/apt/trusted.gpg.d/adoptium.gpg
  wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo gpg --dearmor -o $adoptGpg

  CODEBASE=$(lsb_release -cs)
  if [ -f "/etc/upstream-release/lsb-release" ]; then #it's a Linux Mint...
    CODEBASE=$(grep DISTRIB_CODENAME= /etc/upstream-release/lsb-release | cut -d'=' -f2)
  fi

  echo "deb [signedBy=${adoptGpg}] https://packages.adoptium.net/artifactory/deb ${CODEBASE} main" | sudo tee /etc/apt/sources.list.d/adoptium.list
  sudo apt update
  sudo apt install -y temurin-17-jdk
fi
