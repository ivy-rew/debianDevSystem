#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# overcome broken distrib package -> https://github.com/umlaeute/v4l2loopback
if ! [ -d "$DIR/v4l2loopback" ]; then
  cd "$DIR"
  git clone https://github.com/umlaeute/v4l2loopback.git
fi

cd "$DIR/v4l2loopback"
  make && sudo make install
  sudo depmod -a
  sudo modprobe v4l2loopback
cd ..

# control camera
sudo apt install -y v4l-utils

