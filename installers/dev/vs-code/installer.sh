#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > ${DIR}/packages.microsoft.gpg
sudo install -o root -g root -m 644 ${DIR}/packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
rm ${DIR}/packages.microsoft.gpg

sudo apt update
sudo apt install -y code

codeSettings="$HOME/.config/Code/User/"
mkdir -p "$codeSettings"
cp -v "${DIR}/settings.json" "$codeSettings/settings.json" 
