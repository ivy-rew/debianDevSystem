#!/bin/bash

if [ ! -d "OSX-KVM" ]; then
  git clone https://github.com/kholia/OSX-KVM
fi
cd OSX-KVM

if [ -f "BaseSystem.img" ]; then
  echo "BaseSystem.img already present, you may delete it to enforce a re-download"
  exit 1
fi

if [ ! -f "InstallAssistant.pkg" ]; then
  ./fetch-macOS.py
fi

## unpack pkg https://stackoverflow.com/questions/11093123/run-pkg-files-in-linux
sudo apt install libarchive-tools
bsdtar xvf InstallAssistant.pkg
mkdir shared
mv SharedSupport.dmg shared
cd shared

## https://askubuntu.com/questions/38112/how-can-i-open-a-dmg-file
sudo apt install p7zip-full
7z x SharedSupport.dmg
mkdir hfs
sudo mount -oloop *.hfs hfs

## extract BaseSystem.dmg to root dir
7z x hfs/com_apple_MobileAsset_MacSoftwareUpdate/*.zip AssetData/Restore/BaseSystem.dmg
qemu-img convert AssetData/Restore/BaseSystem.dmg -O raw ../BaseSystem.img

# cleanup
sudo umount hfs
cd ../
rm -rf shared

echo "provided '$(pwd)/BaseSystem.img' successfully."
