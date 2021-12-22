#!/bin/bash

# overcome broken distrib package -> https://github.com/umlaeute/v4l2loopback
git checkout https://github.com/umlaeute/v4l2loopback
cd v4l2loopback
make && sudo make install
sudo depmod -a
sudo modprobe v4l2loopback
cd ..

# control camera
sudo apt install v4l-utils

