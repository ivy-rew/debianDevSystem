#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ohMyZsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

pwrLine10k() {
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  cp ${DIR}/p10k.sh $HOME/.p10k.sh
}

nvmPlugin() {
  zstyle ':omz:plugins:nvm' lazy yes
  plugins=(git nvm)
  source $ZSH/oh-my-zsh.sh
}
