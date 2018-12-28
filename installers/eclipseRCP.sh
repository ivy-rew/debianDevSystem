#!/bin/bash

version=2018-12
if [ ! -z "$1" ]
  then
    version=$1
fi
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd /tmp

#clean
rm eclipse-rcp*.tar.gz
rm -rf eclipse

#get
#wget https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/$version/R/eclipse-rcp-$version-R-linux-gtk-x86_64.tar.gz&r=1
wget http://ftp.fau.de/eclipse/technology/epp/downloads/release/$version/R/eclipse-rcp-$version-R-linux-gtk-x86_64.tar.gz
tar -xzf eclipse-rcp*.tar.gz

TARGET=/opt/eclipse.rcp/
sudo mkdir -p $TARGET
sudo mv -v eclipse $TARGET/$version

rm eclipse-rcp*.tar.gz

$DIR/eclipsePlugins.sh $TARGET/$version
