#!/bin/bash

# pacstall
if ! [ -x "$(command -v pacstall)" ]; then
  echo -e "n" | sudo bash -c "$(curl -fsSL https://pacstall.dev/q/install)"
fi

echo -e "n" | pacstall -I qogir-icon-theme-bin
