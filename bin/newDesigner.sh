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

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=MacOSX-BETA;;
esac
if ! [ -z $machine ]
  then
    echo "setting designer download to ${machine}"
    sed "s/Linux/${machine}/g" .env.template > .env
fi

JENKINS="jenkins.ivyteam.io"
ARTIFACT=designer
ARTIFACT_PATTERN=${DESIGNER_PATTERN}

jenkinsGet $JENKINS $JOB $BRANCH $ARTIFACT $ARTIFACT_PATTERN