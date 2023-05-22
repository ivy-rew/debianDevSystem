#!/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

nvm use 16.20
npm install -g yarn