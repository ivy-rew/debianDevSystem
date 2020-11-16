#!/bin/bash

git clone https://github.com/kholia/OSX-KVM
cd OSX-KVM
./fetch-macOS.py

## unpack pkg https://stackoverflow.com/questions/11093123/run-pkg-files-in-linux
sudo apt install libarchive-tools
bsdtar xvf InstallAssistant.pkg
mkdir shared

## https://askubuntu.com/questions/38112/how-can-i-open-a-dmg-file
7z x SharedSupport.dmg
mkdir hfs
sudo mount -oloop *.hfs hfs

## extract BaseSystem.dmg to root dir
7z x hfs/com_apple_MobileAsset_MacSoftwareUpdate/*.zip AssetData/Restore/BaseSystem.dmg
sudo umount hfs
qemu-img convert AssetData/Restore/BaseSystem.dmg -O raw ../../BaseSystem.img
