#!/bin/bash

sudo apt update
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# cooperate 
$DIR/pidginAndSkype.sh
$IDR/installTeams.sh
$DIR/outlook365/installOutlook.sh

# browse
$DIR/firefox/installFirefox.sh
$DIR/installChromium.sh

# screenshot
$DIR/installShutter.sh
$DIR/installPeekGifRecorder.sh

# password manager
sudo apt install -y keepassx

