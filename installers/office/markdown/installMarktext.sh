#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

wget https://github.com/jacobwhall/marktext/releases/download/v0.17.5/marktext-amd64.deb -O ${DIR}/marktext.deb
sudo apt install -y ${DIR}/marktext.deb
rm ${DIR}/marktext.deb
