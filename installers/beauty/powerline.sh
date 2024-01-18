#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ohMyBash(){
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
  echo "go to .bashrc and select OSH_THEME=powerline"
}

standalone(){
  sudo apt install -y powerline powerline-gitstatus fonts-powerline
  tee -a $HOME/.profile << EOF
# powerline
if [ -f `which powerline-daemon` ]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
fi
EOF
  echo "source ${DIR}/powerRc.sh" | tee -a $HOME/.bashrc
}

standalone
