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
sudo apt install -y chrome

# screenshot/images
sudo apt install -y\
 shutter\
 peek\
 gimp

# passwords
$DIR/installKeePassXC.sh

# pdf-edit
sudo apt install -y\
 xournalpp\
 pdfarranger

# keys+mouse
$DIR/key-presenter/installKeyMon.sh
