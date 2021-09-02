#!/bin/bash

if ! [ -x "$(command -v virt-manager)" ]; then
  sudo apt install qemu-system 
  sudo apt install qemu-kvm bridge-utils
  sudo apt install virt-manager
fi
supported=`qemu-system-x86_64 -machine help | grep pc-q35-4.2`
if [ -z "$supported" ]; then
  echo "Required machine type 'pc-q35-4.2' not supported on your host."
  exit 1
fi

if [ ! -d "OSX-KVM" ]; then
  git clone https://github.com/kholia/OSX-KVM
fi
cd OSX-KVM

if [ -f "BaseSystem.img" ]; then
  echo "BaseSystem.img already present, you may delete it to enforce a re-download"
  exit 1
fi

./fetch-macOS-v2.py

qemu-img convert BaseSystem.dmg -O raw BaseSystem.img

echo "provided '$(pwd)/BaseSystem.img' successfully."
