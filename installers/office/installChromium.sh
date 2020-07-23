#!/bin/bash

# https://linuxmint-user-guide.readthedocs.io/en/latest/chromium.html

echo 'deb http://download.opensuse.org/repositories/home:/ungoogled_chromium/Ubuntu_Focal/ /' | sudo tee /etc/apt/sources.list.d/home:ungoogled_chromium.list
wget -nv https://download.opensuse.org/repositories/home:ungoogled_chromium/Ubuntu_Focal/Release.key -O - | sudo apt-key add -
sudo apt update
sudo apt remove --purge chromium-browser
sudo apt install ungoogled-chromium

