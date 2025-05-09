#!/bin/bash

tuxedoRepo(){
  CODEBASE=$(lsb_release -cs)
  if [ -f "/etc/upstream-release/lsb-release" ]; then #it's a Linux Mint...
    CODEBASE=$(grep DISTRIB_CODENAME= /etc/upstream-release/lsb-release | cut -d'=' -f2)
  fi

  echo "deb https://deb.tuxedocomputers.com/ubuntu ${CODEBASE} main" | sudo tee /etc/apt/sources.list.d/tuxedo-computers.list
  wget https://deb.tuxedocomputers.com/ubuntu/pool/main/t/tuxedo-archive-keyring/tuxedo-archive-keyring_2022.04.01~tux_all.deb
  sudo dpkg -i tuxedo-archive-keyring_2022.04.01~tux_all.deb
  sudo apt update && apt search tuxedo 
}

tuxedoKernel(){
  echo ":::manual steps::: https://github.com/tuxedocomputers/Tuxedo-Linux-Kernel-Self-Signed-Certificate"
  echo ":::manual steps::: sudo apt install linux-tuxedo-24.04"
}

intelGraphics() {
  echo ":::manual steps:::  dmesg | grep i915"
  # id=7d55
  # favour915="xe.force_probe='!$id' i915.force_probe='$id'"
  # sed -i 's|(GRUB_CMDLINE_LINUX_DEFAULT=".*)"|\1$favour915"|g' /etc/default/grub
  # sudo update-grub
}

tuxedoRepo


sudo apt install -y tuxedo-control-center tuxedo-drivers tuxedo-tomte
