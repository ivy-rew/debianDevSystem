#!/bin/bash

sudo apt install -y\
 cockpit\
 gnome-system-log\
 htop\
 ncdu

ADIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$ADIR/keybindings.sh
$ADIR/unattendedUpgrades.sh
$ADIR/qemuVirtManager.sh
