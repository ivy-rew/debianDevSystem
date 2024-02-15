#!/bin/bash

sudo apt update
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# dict
sudo apt install -y libwww-dict-leo-org-perl

# cooperate 
$DIR/pidginAndSkype.sh
$DIR/installTeams.sh
$DIR/outlook365/installOutlook.sh

#author
$DIR/installRemarkable.sh
$DIR/installMarktext.sh

# browse
$DIR/firefox/installFirefox.sh
$DIR/installChromium.sh

# screenshot/images
sudo apt install -y\
 shutter\
 peek\
 gimp

# passwords
sudo apt install -y keepassx
$DIR/installAuthy.sh

# pdf-edit
sudo apt install -y\
 xournalpp\
 pdfarranger
