#!/bin/bash

# stacer https://github.com/oguzhaninan/Stacer
sudo add-apt-repository ppa:oguzhaninan/stacer
sudo apt update
sudo apt install -y stacer

sudo apt install -y\
 cockpit\
 gnome-system-log\
 htop\
 ncdu

ADIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$ADIR/keybindings.sh
$ADIR/unattendedUpgrades.sh
$ADIR/qemuVirtManager.sh
