#!/bin/bash

cd OSX-KVM #to be executed where your OSX-KVM checkout is!

sed "s|/home/CHANGEME/OSX-KVM|$(pwd)|g" macOS-libvirt-Catalina.xml > macOS-libvirt-bigSur.xml

virsh --connect qemu:///system define macOS-libvirt-bigSur.xml
