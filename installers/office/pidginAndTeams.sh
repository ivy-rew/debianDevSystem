#!/bin/bash

sudo apt install -y pidgin

### add skype ###
sudo apt install -y libjson-glib-dev libpurple-dev
git clone https://github.com/EionRobb/purple-teams.git
cd purple-teams
make
sudo make install


