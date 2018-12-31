#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo apt update

sudo apt install -y openjdk-8-jdk
sudo apt install -y openjdk-8-source
sudo apt install -y maven
sudo apt install -y openjfx
sudo apt install -y visualvm

# git
sudo apt install -y git
## keyring integration: https://stackoverflow.com/questions/13385690/how-to-use-git-with-gnome-keyring-integration
sudo apt install -y libgnome-keyring-dev
cd /usr/share/doc/git/contrib/credential/gnome-keyring && sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
$DIR/updateGitKraken.sh

# scm-svn
sudo apt install -y subversion
sudo apt install -y nemo-rabbitvcs

# general eclipse deps
sudo apt install -y libwebkitgtk-1.0.0
sudo apt install -y libsvn-java

# newEngine / newDesigner deps
sudo apt install -y curl jq

# composite installers
$DIR/docker-ce.sh
$DIR/updatePostman.sh
$DIR/eclipseRCP.sh
$DIR/eclipseRCPTT.sh
$DIR/geckodriver-install.sh

# interactive:
echo "select jdk8 as default JRE!"
sudo update-alternatives --config java
$DIR/oxygenXmlAuthor.sh

