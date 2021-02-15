#!/bin/bash

# https://itsfoss.com/install-yarn-ubuntu/
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list'
sudo apt update
sudo apt install -y yarn
