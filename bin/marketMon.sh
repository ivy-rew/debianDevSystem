#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE}" )" && pwd )"
cd $DIR/monitor

python3 -m http.server --cgi
firefox localhost:8000/cgi-bin/marketMon.sh
