#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# debian package is broken today: so we run it from source
git clone https://github.com/scottkirkwood/key-mon.git $DIR/keymon

menuEntry() {
  echo -e "[Desktop Entry]\n\
Encoding=UTF-8
Type=Application\n\
Exec=${DIR}/keymon/src/key-mon\n\
Icon=${DIR}/keymon/icons/key-mon.xpm\n
Name=Key-Mon\n\
GenericName=key.mon\n
Terminal=false\n
StartupNotify=false\n
Categories=Internet" > key.mon.desktop
  sudo cp -v key.mon.desktop /usr/share/applications/
}

menuEntry
