#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt install -y chromium-browser

cat "${DIR}/outlook365.desktop"\
 | sed "s|outlook.sh|${DIR}/outlook.sh|"\
 | sed "s|outlook365.png|${DIR}/outlook365.png|"\
  > $HOME/.local/share/applications/outlook365.desktop
