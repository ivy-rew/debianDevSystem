#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

generatorDir="$DIR/authy-deb-generator"

git clone https://github.com/dstettler/authy-deb-generator $generatorDir
cd $generatorDir

sudo ./authy-install.sh

cd $DIR

