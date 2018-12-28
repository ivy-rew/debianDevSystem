#!/bin/bash

#oxygen xml author
tools=/mnt/zugprofile/tools
sudo mkdir -p $tools
sudo apt install -y cifs-utils
sudo mount -t cifs -o user=$USER //zugprofile/Tools $tools
cd "$tools"/oXygene\ XML\ Editor/12
sudo ./author-linux-64bit.sh
cat license.txt
sudo umount $tools
# ...ui install process with wizard...
echo "--------------------------"
echo "!!!install printed license manually!!!"
echo "--------------------------"
echo "manually adjust prefs: Tools > Preferences > Global > Styles > Default"
