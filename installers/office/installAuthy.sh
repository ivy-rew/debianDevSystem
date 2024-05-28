#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

wget -o $DIR/authy.deb https://archive.org/download/authy/authy.deb
sudo apt install $DIR/authy.deb

