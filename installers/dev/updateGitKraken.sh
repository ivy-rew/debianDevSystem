#!/bin/bash
/usr/bin/wget https://release.gitkraken.com/linux/gitkraken-amd64.deb -v -P /tmp
sudo /usr/bin/dpkg -i /tmp/gitkraken-amd64.deb
rm /tmp/gitkraken-amd64.deb
