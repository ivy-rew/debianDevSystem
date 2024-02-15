#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

wget https://bootstrap.pypa.io/get-pip.py -O ${DIR}/get-pip.py
python3 ${DIR}/get-pip.py
rm ${DIR}/get-pip.py


