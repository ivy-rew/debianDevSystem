#!/bin/bash

sudo apt install -y gtk2-engines-murrine gtk2-engines-pixbuf

dlDir=$HOME/Downloads/Qogir-theme
if ! [ -d "${dlDir}" ]; then
  git clone https://github.com/vinceliuice/Qogir-theme.git ${dlDir}
fi

${dlDir}/install.sh

#firefox 
ffProfile=$HOME/.mozilla/firefox/*.default-release
cp -v -r ${dlDir}/src/firefox/chrome $ffProfile

echo "follow manual steps on: https://github.com/vinceliuice/Qogir-theme/tree/master/src/firefox"

