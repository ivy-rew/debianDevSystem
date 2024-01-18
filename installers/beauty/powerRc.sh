#!/bin/bash

updateTitle(){
  prefix="\u@\h: "
  if [[ -z "$SSH_CLIENT" ]]; then
    prefix=""
  fi
  location="\w\a"
  PS1="\[\e]0;$prefix$location\]$PS1"
}
PROMPT_COMMAND=updateTitle

pwScript=/usr/share/powerline/bindings/bash/powerline.sh
if [ -f "$pwScript" ]; then
  source "$pwScript"
fi
