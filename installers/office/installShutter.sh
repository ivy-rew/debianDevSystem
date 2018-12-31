#!/bin/bash

sudo apt install -y shutter

# edit support: https://itsfoss.com/shutter-edit-button-disabled/
sudo apt install -y libextutils-depends-perl

wget https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas3_1.0.0-1_amd64.deb
sudo dpkg -i libgoocanvas3*.deb

wget https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas-common_1.0.0-1_all.deb
sudo dpkg -i libgoocanvas-common*.deb

wget https://launchpad.net/ubuntu/+archive/primary/+files/libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb
sudo dpkg -i libgoo-canvas-perl*.deb
