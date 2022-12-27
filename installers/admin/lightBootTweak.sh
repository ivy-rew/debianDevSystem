#!/bin/bash

# linux light boots damns slowly; turns out apt-update is run on each boot

sudo chmod -x /etc/network/if-up.d/update

## analyzed boot time via:
# systemd-analyze blame
# systemd-analyze plot > boot.svg

## analyzed issue behind slow networking-service via
# journalctl -u networking.service -b

