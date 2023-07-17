#!/bin/bash

KDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# https://unix.stackexchange.com/questions/422111/linux-mint-cinnamon-18-in-what-file-are-the-keyboard-shortcuts-saved
dconf load /org/cinnamon/desktop/keybindings/ < ${KDIR}/keybindings.dconf
