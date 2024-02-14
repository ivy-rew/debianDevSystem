#!/bin/bash

# VNC for my running session
# > tigervnc performs well also on highly animated cinnamon desktops!
sudo apt install -y tigervnc-standalone-server

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -v $HOME/.vnc
cp -v $DIR/serveAnonym_xstartup $HOME/.vnc/anonymous-vnc_xstartup
cat ${DIR}/vncAliases | tee -a $HOME/.bash_aliases
source $HOME/.bash_aliases
echo "installed aliases: $(cat vncAliases)"
