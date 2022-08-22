#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ohMyBash(){
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
  echo "go to .bashrc and select OSH_THEME=powerline"
}

standalone(){
  sudo apt install -y powerline powerline-gitstatus fonts-powerline
  echo "source ${DIR}/powerRc.sh" | tee -a $HOME/.bashrc
}

standalone
