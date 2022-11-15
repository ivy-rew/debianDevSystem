#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE}" )" && pwd )"
PORT=7777

source $DIR/.env
export GH_TOKEN

rm -v /tmp/gh-*.json
firefox localhost:${PORT}/cgi-bin/marketMon.sh &
python3 -m http.server ${PORT} --directory $DIR/monitor --cgi
