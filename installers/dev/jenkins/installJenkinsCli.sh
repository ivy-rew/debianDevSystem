#!/bin/bash

JDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cliDir=$JDIR/jenkinsCli
if ! [ -d "${cliDir}" ]; then
  git clone https://github.com/ivy-rew/jenkinsCli ${cliDir}
fi

sed "s|cliBin|${cliDir}/bin|g" jenkinsrun-profile | tee -a $HOME/.profile
