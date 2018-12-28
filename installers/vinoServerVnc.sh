#!/bin/bash

# VNC for my running session
sudo apt install -y vino
gsettings set org.gnome.Vino require-encryption false
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino authentication-methods "['vnc']"

# define password
echo -n Enter you password: 
read -s password
echo $password > /tmp/vncpass.txt
ENCODED=$(base64 /tmp/vncpass.txt)
echo ""
echo "using password (base64): $ENCODED"
rm -f /tmp/vncpass.txt
gsettings set org.gnome.Vino vnc-password $ENCODED

# add to startup apps...
echo -e "[Desktop Entry]\n\
Type=Application\n\
Exec=/usr/lib/vino/vino-server\n\
X-GNOME-Autostart-enabled=true\n\
NoDisplay=false\n\
Hidden=false\n\
Name[en_US]=vino-server.desktop\n\
Comment[en_US]=main session VNC\n\
X-GNOME-Autostart-Delay=10" > $HOME/.config/autostart/vino-server.desktop
