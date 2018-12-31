#!/bin/bash

sudo apt update
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# remote-control this workstation
sudo apt install -y openssh-server
$DIR/vinoServerVnc.sh

# rdp remote control
sudo apt install -y remmina
sudo apt install -y remmina-plugin-rdp


