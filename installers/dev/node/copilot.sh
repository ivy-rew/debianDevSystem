#!/bin/bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if ! [ -x "$(command -v npm )" ]; then
  $DIR/nodejs.sh
fi

npm install -g @github/copilot
