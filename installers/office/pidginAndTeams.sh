#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt install -y pidgin

teamsPlugin() {
  sudo apt install -y libjson-glib-dev libpurple-dev
  git clone https://github.com/EionRobb/purple-teams.git ${DIR}/purple-teams
}

updateTeams() {
  cd ${DIR}/purple-teams
  git pull
  make
  sudo make install
}

autoStart() {
# add to startup apps...
echo -e "[Desktop Entry]\n\
Type=Application\n\
Exec=/usr/bin/pidgin\n\
X-GNOME-Autostart-enabled=true\n\
NoDisplay=false\n\
Hidden=false\n\
ICON=pidgin\n\
Name[en_US]=pidgin.desktop\n\
Comment[en_US]=pidgin teams\n\
X-GNOME-Autostart-Delay=10" > $HOME/.config/autostart/pidgin.desktop
}

teamsPlugin
updateTeams
autoStart
