#!/bin/bash

settings() {
  v4l2-ctl -l | grep -A 20 "User" | tail -n +3 | grep -B 20 "Camera"
}

camset() {
  local what="$1"
  echo "setting $what"
  local line=$(v4l2-ctl -l | grep $what)
  echo "$line"
  local min=$(echo "$line" | awk '{print $5;}')
  local min="${min:4}"
  local max=$(echo "$line" | awk '{print $6;}')
  local max="${max:4}"
  local default=$(echo "$line" | awk '{print $8;}')
  local default=${default:8}
  local val=$(echo "$line" | awk '{print $9;}')
  local val=${val:6}
  echo "$min->$max def=$default val=$val"
  local choice=$(dialog --rangebox ${what} 10 200 ${min} ${max} ${val} 2>&1 >/dev/tty )
  echo "setting ${what}=${choice}"
  v4l2-ctl -c ${what}=${choice} 
  # // TODO: life-feedback with a loop, taking inputs after 1 sec?
}

mainMenu() {
  local MENU_OPTIONS=
  local COUNT=0
  local ALL=()
  for i in `settings | awk '{print $1;}'`; do
    echo ${COUNT}
    COUNT=$[COUNT+1]
    MENU_OPTIONS="${MENU_OPTIONS} ${COUNT} $i $i "
    ALL+=($i)
  done

  local cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
  local options=(${MENU_OPTIONS})
  echo "${ALL[@]}"
  local choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
  for choice in $choices; do
    local id=$(($choice-1))
    camset "${ALL[$id]}"
  done
}

#camset "hue"

mainMenu