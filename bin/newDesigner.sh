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

JENKINS=zugprojenkins
ARTIFACT=designer
ARTIFACT_PATTERN=AxonIvyDesigner.*_Linux_x64.zip

jenkinsGet $JENKINS $JOB $BRANCH $ARTIFACT $ARTIFACT_PATTERN
