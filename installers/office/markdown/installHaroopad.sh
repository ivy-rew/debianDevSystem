#!/bin/bash

sudo apt install -y libgconf-2-4
wget https://bitbucket.org/rhiokim/haroopad-download/downloads/haroopad-v0.13.1-x64.deb
sudo apt install -y ./haroopad*.deb
rm haroopad*.deb
