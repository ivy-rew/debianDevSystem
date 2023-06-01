#!/bin/bash

sudo apt update
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt install -y firefox

profile=(~/.mozilla/firefox/*.default-release)

# hide tree style tab bars..
mkdir -p "$profile/chrome"
cp -v userChrome.css "$profile/chrome/userChrome.css"

# enable userChrome.css
# 1. about:config
# 2. search for 'userprof'
# 3. toolkit.legacyUserProfileCustomizations.stylesheets = true
