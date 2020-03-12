#!/bin/bash

# VNC for my running session
# > tigervnc performs well also on highly animated cinnamon desktops!
sudo apt install -y tigervnc-standalone-server

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cp -v $DIR/serveAnonym_xstartup ~/.vnc/anonymous-vnc_xstartup
echo 'alias vncHome="vncserver -localhost no -name home -geometry 1366x768 -xstartup $HOME/.vnc/anonymous-vnc_xstartup  :3"' >> ~/.bash_aliases
echo 'alias vncHomeKill="vncserver -kill :3"' >> ~/.bash_aliases
source ~/.bash_aliases
echo 'installed alias: vncHome/vncHomeKill'
