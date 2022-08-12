#!/bin/bash

# https://forums.linuxmint.com/viewtopic.php?t=202715

sudo apt install -y unattended-upgrades

# ubuntu base (e.g jammy, trusty, ...)
CODENAME=$(grep DISTRIB_CODENAME= /etc/upstream-release/lsb-release | cut -d'=' -f2)

# sources
sources="  'Ubuntu:${CODENAME};'\n  'Ubuntu:${CODENAME}-security';\n  'Ubuntu:${CODENAME}-updates';\n  'Ubuntu:${CODENAME}-backports';"

config=/etc/apt/apt.conf.d/50unattended-upgrades
prefix="Unattended-Upgrade::Allowed-Origins {"
awk "/$prefix/{print;print \"$sources\";next}1" $config | sudo tee $config

echo "!!!!remove single quotes in $config manually!!!!"

# verify
sudo unattended-upgrades --verbose --dry-run

# enable
sudo dpkg-reconfigure -plow unattended-upgrades
