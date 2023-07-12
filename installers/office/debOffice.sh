#!/bin/bash

sudo apt update
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# dict
sudo apt install -y libwww-dict-leo-org-perl

# cooperate 
$DIR/pidginAndSkype.sh
$DIR/installTeams.sh
$DIR/outlook365/installOutlook.sh
$DIR/installAuthy.sh

#author
$DIR/installHaroopad.sh

# browse
$DIR/firefox/installFirefox.sh
$DIR/installChromium.sh

# screenshot
sudo apt install -y shutter
sudo apt install -y peek

# password manager
sudo apt install -y keepassx

