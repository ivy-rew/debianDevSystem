#!/bin/bash  

source jenkinsGet.sh

JOB=ivy-core_product
if [ ! -z "$1" ]
  then
    JOB=$1
fi

JENKINS=zugprojenkins
BRANCH=master
ARTIFACT=engine
ARTIFACT_PATTERN=AxonIvyEngine[0-9\.]*_All_x64.zip

jenkinsGet $JENKINS $JOB $BRANCH $ARTIFACT $ARTIFACT_PATTERN

