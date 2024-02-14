#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt install -y zsh

source "${DIR}/powerline10k.sh"
ohMyZsh
