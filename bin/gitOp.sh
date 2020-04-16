#!/bin/bash  

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias gf='git fetch --all'

function newBranch()
{
  remote="master"
  if [ ! -z "$2" ]; then
    remote="$2"
  fi
  gf
  git checkout -b "$1" "origin/${remote}"
}

function moveBranch()
{
  target="$1"
  echo "moving to $target"
  git rebase --onto "$target" "origin/HEAD"
}

function updateBranch()
{
  gf
  moveBranch "origin/master"
}

function adaptBranchTo()
{
  current=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  shortTarget=$(basename $1) #only last part /master or /8.0"
  adapted="${current}_${shortTarget}" 
  echo "preparing $adapted"
  git checkout -b "$adapted" "$current"
  git merge -q "$1"
  git push -u origin "HEAD:$adapted"
  git checkout "$current" #back to initial
}

function ltsBranch()
{
  gf
  moveBranch "lts8base"
  adaptBranchTo "origin/master"
  adaptBranchTo "origin/release/8.0"
}
