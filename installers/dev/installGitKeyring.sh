#!/bin/bash

## keyring integration: https://stackoverflow.com/questions/13385690/how-to-use-git-with-gnome-keyring-integration
sudo apt-get install -y libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret && sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
