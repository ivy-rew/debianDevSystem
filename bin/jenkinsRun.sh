#!/bin/bash  

# [BETA]
# attempt to automate lazy triggered builds that belong to my just PUSHED contents...
# 

BRANCH=feature%252FXIVY-3272-streamline-defaults
if [ ! -z "$1" ]
  then
    BRANCH=$1
fi

JOB=ivy-core_ci
if [ ! -z "$2" ]
  then
    JOB=$2
fi

JENKINS=zugprojenkins

echo -n "Enter JENKINS password:\n" 
read -s password

CRUMB=`wget -q --auth-no-challenge --user rew --password $password --output-document - 'http://zugprojenkins/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'`
echo "GOT CRUMB: " $CRUMB

BUILD_URL="http://$JENKINS/job/$JOB/job/$BRANCH/build?delay=0sec"
curl -I -X POST -u rew "$BUILD_URL" -H "$CRUMB"

