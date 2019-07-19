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
URL="http://zugprojenkins/job/$JOB/"


function triggerBuilds() {
    BRANCH=$1
    echo "triggering builds for $BRANCH"

    user=`whoami`
    echo -n "Enter JENKINS password for $user:" 
    echo -n ""
    read -s password
    echo ""

    CRUMB=`wget -q --auth-no-challenge --user $user --password $password --output-document - 'http://zugprojenkins/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'`
    echo "GOT CRUMB: " $CRUMB

    JSON=`curl -s "http://$JENKINS/api/json?tree=jobs[name]"`
    JOBS=`echo $JSON | jq '.jobs[].name' | grep 'ivy-core_test'`
    select RUN in none '"ivy-core_ci"' $JOBS
    do
        if [ "$RUN" == "none" ]
        then
            break
        fi
        RUN_JOB=${RUN:1:-1}
        BUILD_URL="http://$JENKINS/job/$RUN_JOB/job/$BRANCH/build?delay=0sec"
        curl -I -X POST -u "$user:$password" "$BUILD_URL" -H "$CRUMB"
    done
}

#get available jobs: 
function getAvailableBranches()
{
  JSON=`curl -s "$URL/api/json?tree=jobs[name]"`
  BRANCHES=`echo $JSON | jq '.jobs[].name'`
  echo $BRANCHES
}
BRANCHES=$( getAvailableBranches )

echo "SELECT branch of $URL"
select BRANCH_SELECTED in 're-scan' $BRANCHES
do
    if [ "$BRANCH_SELECTED" == "re-scan" ]
    then
        echo 're-scanning [beta]'
        BRANCHES=$( getAvailableBranches )
    else
        triggerBuilds ${BRANCH_SELECTED:1:-1} #kill hyphens
        break
    fi
done

