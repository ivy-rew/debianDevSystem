#!/bin/bash

# inodes
# https://unix.stackexchange.com/questions/13751/kernel-inotify-watch-limit-reached


limit=524288

current=$(cat /proc/sys/fs/inotify/max_user_watches)

if [ "$current" -ne "$limit" ]; then
  echo "changing inode.limit from $current to $limit"
  echo "fs.inotify.max_user_watches=${limit}" | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p
fi
