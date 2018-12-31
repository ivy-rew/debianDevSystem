#!/bin/bash

sudo apt update
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt install -y firefox

ffDir=~/.mozilla/firefox/*.default

# hide tree style tab bars..
mkdir -p $ffDir/chrome
cp $DIR/userChrome.css $ffDir/chrome/userChrome.css

