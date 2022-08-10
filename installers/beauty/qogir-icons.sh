#!/bin/bash

# pacstall
if ! [ -x "$(command -v pacstall)" ]; then
  sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
fi

pacstall -I qogir-icon-theme-bin
