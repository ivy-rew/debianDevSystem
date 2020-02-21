#!/bin/bash

# bash script quemu based macos
# https://www.funkyspacemonkey.com/how-to-install-macos-catalina-on-linux

# get mac os
sudo apt install python3 python3-pip
git clone https://github.com/foxlet/macOS-Simple-KVM.git
cd macOS-Simple-KVM
./jumpstart.sh --catalina

# virtualize
sudo apt install qemu-utils 
if [ ! -d '/mnt/kvm' ]; then
    sudo mkdir /mnt/kvm
fi
DISK='/mnt/kvm/macOScatalina.qcow2'
# at least 24 G are required to install catalina > work with a second disk for your data to ease migration!
qemu-img create -f qcow2 $DISK 30G
printf "    -drive id=SystemDisk,if=none,file=${DISK} \\" >> basic.sh
printf "\n" >> basic.sh
printf "    -device ide-hd,bus=sata.4,drive=SystemDisk \\" >> basic.sh

# as in the tutorial
sudo apt install qemu-system 

# integrate libvirt service and ui 
sudo apt install qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils
sudo apt install virt-manager

# rock'n roll
sudo ./basic.sh
