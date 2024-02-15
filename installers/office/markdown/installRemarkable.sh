#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git clone https://github.com/seiferteric/remarkable_debfix.git ${DIR}/remarkable_debfix
cd ${DIR}/remarkable_debfix/
dpkg-deb -Z xz -b old_deb remarkable_1.87_all.deb
sudo apt install -y ./remarkable*.deb
