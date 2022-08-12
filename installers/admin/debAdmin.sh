# stacer
# cockpit

# stacer https://github.com/oguzhaninan/Stacer
sudo add-apt-repository ppa:oguzhaninan/stacer
sudo apt update
sudo apt install -y stacer

sudo apt install -y cockpit
sudo apt install -y gnome-system-log 

ADIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$ADIR/unattendedUpgrades.sh
