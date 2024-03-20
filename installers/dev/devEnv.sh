#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo apt update

$DIR/installAdoptiumJdk.sh
sudo apt install -y temurin-17-jdk-amd64 #lts support
sudo apt install -y openjdk-17-source
sudo apt install -y maven
sudo apt install -y openjfx
sudo apt install -y visualvm
$DIR/installMaven.sh

# git
sudo apt install -y git
$DIR/installGitKeyring.sh

# general eclipse deps
sudo apt install -y libwebkit2gtk-4.0-37
sudo apt install -y libswt-gtk-4-java

# utils
sudo apt install -y meld gitk
sudo apt install -y git-quick-stats

# bash
cat $DIR/dev-bashrc | tee -a $HOME/.bashrc
cat $DIR/dev-bash_aliases | tee -a $HOME/.bash_aliases

# composite installers
$DIR/jenkins/installJenkinsCli.sh
$DIR/docker-ce.sh
$DIR/inodesLimit.sh
$DIR/installOneFetch.sh
$DIR/updatePostman.sh
$DIR/eclipse/eclipseRCP.sh
$DIR/eclipse/eclipseRCPTT.sh
$DIR/vs-code/installer.sh
$DIR/node/nodejs.sh
$DIR/python/installPip.sh
