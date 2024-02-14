#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt install -y pidgin

### add skype ###
sudo apt install -y libjson-glib-dev libpurple-dev
git clone https://github.com/EionRobb/purple-teams.git ${DIR}/purple-teams
cd ${DIR}/purple-teams
make
sudo make install


