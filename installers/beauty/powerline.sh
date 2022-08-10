#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ohMyBash(){
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
  echo "go to .bashrc and select OSH_THEME=powerline"
}

standalone(){
  sudo install -y python3-pip
  sudo pip3 install powerline-status
  cat ${DIR}/powerRc | tee -a $HOME/.bashrc
}

sudo apt-get install fonts-powerline
standalone
