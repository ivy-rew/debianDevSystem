#!/bin/bash  

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias gf='git fetch --all'

newBranch(){
  remote="master"
  if [ ! -z "$2" ]; then
    remote="$2"
  fi
  gf
  git checkout -b "$1" "origin/${remote}"
}

parentCommit(){
  git rev-list -n 1 "origin/HEAD"
}

moveBranch(){
  target="$1"
  oldParent="$2"
  if [ -z "$2" ]; then
    oldParent="origin/HEAD"
  fi
  echo "moving to $target"
  git rebase --onto "$target" "$oldParent"
}

updateBranch(){
  gf
  moveBranch "origin/master"
}

adaptBranchTo(){
  current=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  shortTarget=$(basename $1) #only last part /master or /8.0"
  adapted="${current}_${shortTarget}" 
  git checkout -b "$adapted" "$current"
  git merge -q "$1"
  git push -u origin "HEAD:$adapted"
  git checkout "$current" #back to initial
}

lts8Branch(){
  gf
  moveBranch "lts8base"
  adaptBranchTo "origin/release/8.0"
  adaptBranchTo "origin/master"
  # back to master ... (avoid compile cycles :-/)
}

ltsBranch(){
  parent=$(parentCommit)
  gf
  dev="dev10.0"
  moveBranch "origin/${dev}" "$parent"
  # push -f
  # push origin "HEAD:${dev}"
}
