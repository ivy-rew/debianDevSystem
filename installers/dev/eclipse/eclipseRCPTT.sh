#!/bin/bash

version=2.3.0
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd /tmp
wget https://mirrors.dotsrc.org/eclipse//rcptt/release/$version/ide/rcptt.ide-$version-linux.gtk.x86_64.zip
sudo unzip rcptt.ide*.zip -d /opt/rcptt$version.ide
rm rcptt.ide*.zip

$DIR/eclipseRCPTTPlugins.sh $version
