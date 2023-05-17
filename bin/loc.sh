#!/bin/bash
# lines-of-code counter. 
# inspired by https://stackoverflow.com/questions/6924158/eclipse-count-lines-of-code

what="*.java"
if [ ! -z "$1" ]; then
  what="$1"
fi

count(){
  where="$1"
  all=$(find ${where} -name ${what} -exec cat {} \; | wc -l)
  lines=$(find ${where} -name ${what} -exec grep "[a-zA-Z0-9]" {} \; | wc -l)
  echo "lines of ${what} code in ${where}: all=${all} code=${lines}"
}

count $PWD
