#!/bin/bash

curmonth=$(date +%m)
year=$(date +%Y)

if [ "$curmonth" -gt "09" ]; then   
	month="09"
elif [ "$curmonth" -gt "06" ]; then   
	month="06"
elif [ "$curmonth" -gt "03" ]; then
	month="03"
else
	month="12"
	year=$(date -d "-1 year" +%Y)
fi

defVersion="$year-$month"

if [ ! -z "$1" ];then
  version=$1
else
  read -p "Download Eclipse RCP version [${defVersion}]: " version && version=${version:-${defVersion}}
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

#raise memory
xms=2G
xmx=4G
sed -i -e 's/\-Xms.*/-\Xms'"$xms"'/g; s/\-Xmx.*/\-Xmx'"$xmx"'/g' ./eclipse/eclipse.ini


TARGET=/opt/eclipse.rcp/
sudo mkdir -p $TARGET
sudo mv -v eclipse $TARGET/$version

rm eclipse-rcp*.tar.gz

$DIR/eclipsePlugins.sh $TARGET/$version
