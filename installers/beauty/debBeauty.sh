#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/qogir-theme.sh
$DIR/qogir-icons.sh
$DIR/applets/installApplets.sh
$DIR/backgrounds.sh

# $DIR/bash/powerline.sh
$DIR/zsh/installZsh.sh

# terminal: adapt system theme
dconf write /org/gnome/terminal/legacy/theme-variant "'system'"
