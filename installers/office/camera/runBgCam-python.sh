#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

loopBack=$(v4l2-ctl --list-devices | grep -A 2 v4l2loopback | grep -o -E /dev/video[0-9]+)
if [ -z "$loopBack" ]; then
  echo "no loopback device: installing"
  sudo modprobe v4l2loopback devices=1
fi

cd "${DIR}/Linux-Fake-Background-Webcam"
python3.8 fake.py "$@"
