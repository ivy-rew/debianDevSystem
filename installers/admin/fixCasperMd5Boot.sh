#!/bin/bash

#remove casper md5-check error on boot: Ubuntu 22.04
# https://askubuntu.com/questions/1421093/ubuntu-boot-systemd1-failed-to-start-casper-md5check-verify-live-iso-checksum

sudo apt remove casper -y
systemctl status casper-md5check.service
sudo rm -v /etc/systemd/system/casper.service
sudo rm -v /etc/systemd/system/multi-user.target.wants/casper-md5check.service
sudo rm -v /etc/systemd/system/final.target.wants/casper.service
sudo systemctl daemon-reload
sudo systemctl reset-failed
systemctl --failed
