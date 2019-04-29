
# a lightweight active directory browser
INSTALLER=/tmp/jxplorer-install
wget http://sourceforge.net/projects/jxplorer/files/jxplorer/version%203.3.1.2/jxplorer-3.3.1.2-linux-installer.run/download --output-document=$INSTALLER
sudo chmod +x $INSTALLER
sudo $INSTALLER --prefix /opt/jxplorer --mode unattended --unattendedmodeui minimal

