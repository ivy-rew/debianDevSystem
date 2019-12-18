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
ARTIFACT=engine
ARTIFACT_PATTERN=AxonIvyEngine[0-9\.]*_All_x64.zip

jenkinsGet $JENKINS $JOB $BRANCH $ARTIFACT $ARTIFACT_PATTERN

