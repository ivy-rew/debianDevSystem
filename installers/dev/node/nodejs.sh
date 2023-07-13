#!/bin/bash

#node-version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

#make bins functional for now: without reloading my bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

version=16.20
nvm install "${version}"
nvm use "${version}"
nvm alias default "v${version}"

npm install -g yarn
