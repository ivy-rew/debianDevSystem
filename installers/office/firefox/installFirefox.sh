#!/bin/bash

sudo apt update
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt install -y firefox

hideTabs() {
  profile=(~/.mozilla/firefox/*.default-release)

  # hide tree style tab bars..
  mkdir -p "$profile/chrome"
  cp -v ${DIR}/userChrome.css "$profile/chrome/userChrome.css"

  # enable userChrome.css
  echo "====> enable userChrome.css manually after installing TreeStyleTabs addon <===="
  echo " 1. about:config"
  echo " 2. search for 'userprof'"
  echo " 3. toolkit.legacyUserProfileCustomizations.stylesheets = true"
  echo "========================================================================"
}

hideTabs
