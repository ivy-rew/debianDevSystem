#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo apt update

sudo apt install -y openjdk-8-jdk
sudo apt install -y openjdk-8-source
sudo apt install -y openjdk-11-source
sudo apt install -y maven
sudo apt install -y openjfx
sudo apt install -y visualvm

# git
sudo apt install -y git
## keyring integration: https://stackoverflow.com/questions/13385690/how-to-use-git-with-gnome-keyring-integration
sudo apt install -y libgnome-keyring-dev
cd /usr/share/doc/git/contrib/credential/gnome-keyring && sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring

# general eclipse deps
sudo apt install -y libwebkit2gtk-4.0-37
sudo apt install -y libswt-gtk-4-java

# composite installers
$DIR/docker-ce.sh
$DIR/inodesLimit.sh
$DIR/updatePostman.sh
$DIR/eclipse/eclipseRCP.sh
$DIR/eclipse/eclipseRCPTT.sh
$DIR/geckodriver-install.sh
$DIR/vs-code/installer.sh

