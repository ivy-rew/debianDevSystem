#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ohMyZsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

zshrc=$HOME/.zshrc

pwrLine10k() {
  ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
  P10Kdir=${ZSH_CUSTOM}/themes/powerlevel10k
  echo ${P10KDir}
  if [ ! -d ${P10Kdir} ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${P10Kdir}
  fi
  cp -v ${DIR}/p10k.zsh $HOME/.p10k.zsh
  cat <<EOF | tee -a ${zshrc}

# To customize prompt, run 'p10k configure' or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF
  sed -i 's|ZSH_THEME=".*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ${zshrc}
}

nerdFonts() {
  fonts=~/.local/share/fonts
  mkdir -p ${fonts}
  curl -fLO --output-dir ${fonts} https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
}

nvmPlugin() {
  lazyNvm="zstyle ':omz:plugins:nvm' lazy yes"
  cat ${zshrc}\
   | sed "s|^plugins=|${lazyNvm}\nplugins=|"\
   | sed 's|^plugins=.*|plugins=(nvm)|'\
   > $DIR/zshrc.mod
   cp -v $DIR/zshrc.mod ${zshrc}
}

echo $zshrc