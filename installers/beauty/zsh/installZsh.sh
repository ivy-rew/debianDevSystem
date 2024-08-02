#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt install -y zsh
# as default shell:
chsh -s $(which zsh)

source "${DIR}/powerline10k.sh"
ohMyZsh
pwrLine10k
nerdFonts
nvmPlugin
