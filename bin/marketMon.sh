#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE}" )" && pwd )"
cd $DIR/monitor

source $DIR/.env
firefox localhost:8000/cgi-bin/marketMon.sh &
python3 -m http.server --cgi
