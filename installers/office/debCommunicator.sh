#!/bin/bash

sudo apt update
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# cooperate 
$DIR/pidginAndSkype.sh
$DIR/outlook365/installOutlook.sh


