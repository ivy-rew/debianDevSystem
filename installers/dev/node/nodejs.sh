#!/bin/bash

#node-version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
version=16.20
nvm use "${version}"
nvm alias default "v${version}"

npm install -g yarn