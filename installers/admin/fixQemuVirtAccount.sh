#!/bin/bash

#https://askubuntu.com/questions/897026/why-do-i-have-a-libvirt-qemu-account-in-lock-switch-account-options-in-ubuntu

printf "[User]\nSystemAccount=true\n" | sudo tee /var/lib/AccountsService/users/libvirt-qemu
sudo systemctl restart accounts-daemon.service
