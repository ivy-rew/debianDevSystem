#!/bin/bash  

# [BETA]
# attempt to automate lazy triggered builds that belong to my just PUSHED contents...
# 

SELECT=$1

JOB=ivy-core_ci
if [ ! -z "$3" ]
  then
    JOB=$3
fi

JENKINS=zugprojenkins

function triggerBuilds() {
    BRANCH=$1
    echo "triggering builds for $BRANCH"

    user=`whoami`
    echo -n "Enter JENKINS password for $user:" 
    echo -n ""
    read -s password

    CRUMB=`wget -q --auth-no-challenge --user $user --password $password --output-document - 'http://zugprojenkins/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'`
    echo "GOT CRUMB: " $CRUMB

    BUILD_URL="http://$JENKINS/job/$JOB/job/$BRANCH/build?delay=0sec"
    curl -I -X POST -u "$user:$password" "$BUILD_URL" -H "$CRUMB"
}

#get available jobs: 
URL="http://zugprojenkins/job/$JOB/"
echo "SELECT branch of $URL"
JSON=`curl -s "$URL/api/json?tree=jobs[name]"`
JOBS=`echo $JSON | jq '.jobs[].name'`
select BRANCH_SELECTED in $JOBS
do
    triggerBuilds ${BRANCH_SELECTED:1:-1} #kill hyphens
    break
done

