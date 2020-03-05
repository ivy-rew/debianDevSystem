#!/bin/bash  

source jenkinsGet.sh

BRANCH=master
if [ ! -z "$1" ]
  then
    BRANCH=$1
fi

JOB=ivy-core_product
if [ ! -z "$2" ]
  then
    JOB=$2
fi

JENKINS="jenkins.ivyteam.io"
ARTIFACT=designer
ARTIFACT_PATTERN=${DESIGNER_PATTERN}

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
if [ "${machine}" == Mac ] 
  then
    sed -i 's/Linux/MacOSX-BETA/g' .env.template
    cp .env.template .env
fi

jenkinsGet $JENKINS $JOB $BRANCH $ARTIFACT $ARTIFACT_PATTERN