#!/bin/bash  

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias gf='git fetch --all'
alias gap='git commit --amend && git push -f'

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

cleanBranchesMerged() {
  git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -d
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
  devBranch "dev10.0"
}

devBranch(){
  dev="$1"
  if [ -z "$1" ]; then
    dev="dev11.3"
  fi
  parent=$(parentCommit)
  gf
  moveBranch "origin/${dev}" "$parent"
  echo "rebased!!"

  git --no-pager log "origin/${dev}"~1..HEAD
  echo "Force-Push it for you to upstream?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) git push -f; break;;
      No ) break;;
    esac
  done
  
  echo "Push to origin/${dev}?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) git push origin "HEAD:${dev}"; break;;
      No ) break;;
    esac
  done
}
