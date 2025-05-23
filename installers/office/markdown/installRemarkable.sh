#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git clone https://github.com/ivy-rew/remarkable_debfix.git ${DIR}/remarkable_debfix
cd ${DIR}/remarkable_debfix/
git checkout noble
dpkg-deb -Z xz -b old_deb remarkable_1.87_all.deb
sudo apt install -y ./remarkable*.deb

# spellchecker: https://pypi.org/project/pygtkspellcheck/
sudo apt install -y python3-gtkspellcheck
