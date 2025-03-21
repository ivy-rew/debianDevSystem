#!/bin/bash

if [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]$ ]]; then
  version=$1
else
  defVersion=2.5.5
  read -p "Download RCPTT version [${defVersion}]: " version && version=${version:-${defVersion}}
fi

dlUrl=https://mirrors.dotsrc.org/eclipse//rcptt/release/$version/ide/rcptt.ide-$version-linux.gtk.x86_64.zip
if [[ "$1" == http* ]]; then
    # simplify nightly installation via unique URI from https://www.eclipse.org/rcptt/download/
    dlUrl=$1
    # version from URI:
    artifact=`basename $dlUrl`
    noarch=${artifact%%\-linux\.gtk\.x86_64\.zip}
    version=${noarch##rcptt\.ide\-}
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
rcpttDir=/opt/eclipse.rcptt/rcptt${version}.ide

download() {
  echo "Downloading RCPTT IDE $version"
  cd /tmp
  wget $dlUrl
  sudo mkdir -p ${rcpttDir}
  sudo unzip rcptt.ide*.zip -d ${rcpttDir}
  rm rcptt.ide*.zip
}

temurin() {
  jvm=/usr/lib/jvm/temurin-21-jdk-amd64/bin
  sudo sed -i -e 's|\-vmargs|-vm\n'"$jvm"'\n\-vmargs|g' "${rcpttDir}/rcptt/rcptt.ini"
}

menuEntry() {
  echo -e "[Desktop Entry]\n\
Encoding=UTF-8
Type=Application\n\
Exec=${rcpttDir}/rcptt/rcptt\n\
Icon=${rcpttDir}/rcptt/icon.xpm\n
Name=RCPTT.IDE ${version}\n\
GenericName=rcptt.ide ${version}\n
Terminal=false\n
StartupNotify=false\n
Categories=Development" > eclipse.rcptt.desktop
  sudo cp -v eclipse.rcptt.desktop /usr/share/applications/
}

download
temurin
menuEntry
$DIR/eclipseRCPTTPlugins.sh $version

