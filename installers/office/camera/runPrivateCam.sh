#!/bin/bash

# overcome video limitations of MS Teams:
# https://askubuntu.com/questions/881305/is-there-any-way-ffmpeg-send-video-to-dev-video0-on-ubuntu#881341
# 
# main goal:
# - hide my home office location

sourceVid=/dev/video0

loopBack=$(v4l2-ctl --list-devices | grep -A 2 v4l2loopback | grep -o -E /dev/video[0-9]+)
targetVid=${loopBack}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
background="${DIR}/backgroundIvy.png"

chroma="[1]chromakey=color=#a6ae8d:similarity=0.03:blend=0.05[fg]"
overlay="[0][fg]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=auto,format=yuv420p"
filterScript="${chroma};${overlay}"

echo "starting virtual video ${targetVid}"
echo "ffplay ${targetVid}"
echo ""

# runVirtualCam
ffmpeg -hide_banner -re -i "${background}" -f v4l2 -i ${sourceVid} \
  -filter_complex "${filterScript}" -f v4l2 $targetVid

# verify
#ffplay /dev/video2