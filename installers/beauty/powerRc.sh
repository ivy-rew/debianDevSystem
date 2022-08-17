#!/bin/bash

if [ -f `which powerline-daemon` ]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
fi

updateTitle(){
  prefix="\u@\h: "
  if [[ -z "$SSH_CLIENT" ]]; then
    prefix=""
  fi
  location="\w\a"
  PS1="\[\e]0;$prefix$location\]$PS1"
}
PROMPT_COMMAND=updateTitle

pwScript=$(ls /usr/local/lib/python*/dist-packages/powerline/bindings/bash/powerline.sh)
if [ -f "$pwScript" ]; then
  source "$pwScript"
fi
