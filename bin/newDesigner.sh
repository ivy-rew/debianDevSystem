#!/bin/bash  

source jenkinsGet.sh

JOB=ivy-core_product
if [ ! -z "$1" ]
  then
    JOB=$1
fi

JENKINS=zugprojenkins
BRANCH=master
ARTIFACT=designer
ARTIFACT_PATTERN=AxonIvyDesigner.*_Linux_x64.zip

jenkinsGet $JENKINS $JOB $BRANCH $ARTIFACT $ARTIFACT_PATTERN
