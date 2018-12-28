#!/bin/bash

sudo apt install -y pidgin

### add skype ###
sudo apt-get install libpurple-dev libjson-glib-dev cmake gcc
git clone git://github.com/EionRobb/skype4pidgin.git
cd skype4pidgin/skypeweb
mkdir build
cd build
cmake ..
cpack

### install ####
sudo dpkg -i skypeweb-*-Linux.deb
