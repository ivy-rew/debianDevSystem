#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/qogir-theme.sh
$DIR/qogir-icons.sh
$DIR/backgrounds.sh

# $DIR/bash/powerline.sh
$DIR/zsh/installZsh.sh
