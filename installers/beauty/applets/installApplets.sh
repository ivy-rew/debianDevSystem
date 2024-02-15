#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

applets=$HOME/.local/share/cinnamon/applets
baseUri=https://cinnamon-spices.linuxmint.com/files/applets

appletInst() {
  applet=$1
  wget ${baseUri}/${applet}.zip -O ${applets}/dl.zip
  unzip ${applets}/dl.zip -d ${applets}
  rm ${applets}/dl.zip
}

dark=darkMode@linuxedo.com
appletInst ${dark}

echo "====>> "
echo " you have to MANUALLY import settings from ${DIR}/darkAppletQogir.json"
echo "====<< "
