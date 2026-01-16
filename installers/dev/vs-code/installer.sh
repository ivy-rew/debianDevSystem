#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

instPkg() {
  # https://code.visualstudio.com/docs/setup/linux
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > ${DIR}/packages.microsoft.gpg
  sudo install -o root -g root -m 644 ${DIR}/packages.microsoft.gpg /usr/share/keyrings/microsoft.gpg
  rm ${DIR}/packages.microsoft.gpg
  
  sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null <<EOF
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF

  sudo apt update
  sudo apt install -y code
}

instSettings(){
  codeSettings="$HOME/.config/Code/User/"
  mkdir -p "$codeSettings"
  cp -v "${DIR}/settings.json" "$codeSettings/settings.json"
  cp -v "${DIR}/keybindings.json" "$codeSettings/keybindings.json"
}

instExt() {
  code --install-extension alphabotsec.vscode-eclipse-keybindings
  code --install-extension redhat.vscode-yaml
  code --install-extension mhutchie.git-graph
  code --install-extension huizhou.githd
  code --install-extension catppuccin.catppuccin-vsc-icons
}

instPkg
instSettings
instExt
