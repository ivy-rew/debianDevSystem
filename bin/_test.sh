#!/bin/bash

if ! [ -x "$(command -v bats)" ]; then
  sudo apt install -y bats
fi

bats .