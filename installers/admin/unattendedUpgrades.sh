#!/bin/bash

# https://forums.linuxmint.com/viewtopic.php?t=202715

sudo apt install -y unattended-upgrades

# ubuntu base (e.g jammy, trusty, ...)
CODENAME=$(grep DISTRIB_CODENAME= /etc/upstream-release/lsb-release | cut -d'=' -f2)

config=/etc/apt/apt.conf.d/51unattended-upgrades-mint
echo 'Unattended-Upgrade::Allowed-Origins {
  "linuxmint:${distro_codename}";
' | sudo tee $config
echo "  \"Ubuntu:${CODENAME}\";
  \"Ubuntu:${CODENAME}-security\";
  \"Ubuntu:${CODENAME}-updates\";
  \"Ubuntu:${CODENAME}-backports\";
}
" | sudo tee -a $config


# verify
sudo unattended-upgrades --verbose --dry-run

# enable
sudo dpkg-reconfigure -plow unattended-upgrades
