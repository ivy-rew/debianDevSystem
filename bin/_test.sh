#!/bin/bash

if ! [ -x "$(command -v shunit2)" ]; then
  sudo apt install -y shunit2
fi

shunit2 `ls -v *_test.sh`