#!/bin/bash  

# [BETA]
# attempt to automate lazy triggered builds that belong to my just PUSHED contents...
# 
# [Inspired]
# ...by http://www.inanzzz.com/index.php/post/jnrg/running-jenkins-build-via-command-line

SELECT=$1

JOB=ivy-core_ci
if [ ! -z "$3" ]
  then
    JOB=$3
fi

JENKINS=zugprojenkins
URL="http://zugprojenkins/job/$JOB/"
JENKINS_USER=`whoami`

# ensure dependent binaries exist
if ! [ -x "$(command -v curl)" ]; then
  sudo apt install -y curl
fi
if ! [ -x "$(command -v jq)" ]; then
  sudo apt install -y jq
fi


function triggerBuilds() {
    BRANCH=$1
    echo "triggering builds for $BRANCH"

    if [ -z ${JENKINS_TOKEN+x} ]
    then
        echo "Jenkins API token not found as enviroment variable called 'JENKINS_TOKEN'. Therefore password for jenkins must be entered:"
        echo -n "Enter JENKINS password for $JENKINS_USER:" 
        echo -n ""
        read -s JENKINS_TOKEN
        echo ""
    fi

    # get XSS preventention token
    CRUMB=`wget -q --auth-no-challenge --user $JENKINS_USER --password $JENKINS_TOKEN --output-document - 'http://zugprojenkins/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'`
    echo "GOT CRUMB: " $CRUMB

    JSON=`curl -s "http://$JENKINS/api/json?tree=jobs[name]"`
    JOBS=`echo $JSON | jq '.jobs[].name' | grep 'ivy-core_test'`
    select RUN in none '"ivy-core_ci"' '"ivy-core_product"' $JOBS
    do
        if [ "$RUN" == "none" ]
        then
            break
        fi
        RUN_JOB=${RUN:1:-1}
        BUILD_URL="http://$JENKINS/job/$RUN_JOB/job/$BRANCH/build?delay=0sec"
        RESPONSE=`curl --write-out %{http_code} --silent --output /dev/null -I -X POST -u "$JENKINS_USER:$JENKINS_TOKEN" "$BUILD_URL" -H "$CRUMB"`
        echo "jenkins returned HTTP code : $RESPONSE"
        
        if [ "$RESPONSE" == 404 ] ; then
            # job may requires a manual rescan to expose our new branch
            rescanBranches "http://$JENKINS/job/$RUN_JOB/"
        fi
    done
}

#get available jobs: 
function getAvailableBranches()
{
  JSON=`curl -s "$URL/api/json?tree=jobs[name]"`
  BRANCHES=`echo $JSON | jq '.jobs[].name'`
  echo $BRANCHES
}

function rescanBranches()
{
  JOB_URL=$1
  ACTION="build?delay=0"
  SCAN_URL="$JOB_URL$ACTION"
  HTTP_STATUS=`curl --write-out %{http_code} --silent --output /dev/null -I -L -X POST -u "$JENKINS_USER:$JENKINS_TOKEN" "$SCAN_URL"`
  echo "triggered rescan triggered for $SCAN_URL"
  
  if [[ $HTTP_STATUS == *"200"* ]]; then
    echo "jenkins returned status $HTTP_STATUS. Waiting for index job to finish"
    ACTION="indexing/consoleText"
    until [[ $(curl --write-out --output /dev/null --silent $JOB_URL$ACTION) == *"Finished:"* ]]; do
      printf "."
      sleep 1
    done
  else
    echo "failed: Jenkins returned $HTTP_STATUS"
  fi

}

BRANCHES=$( getAvailableBranches )

echo "SELECT branch of $URL"
select BRANCH_SELECTED in 're-scan' $BRANCHES
do
    if [ "$BRANCH_SELECTED" == "re-scan" ]
    then
        echo 're-scanning [beta]'
        rescanBranches $URL
        BRANCHES=$( getAvailableBranches )
    else
        triggerBuilds ${BRANCH_SELECTED:1:-1} #kill hyphens
        break
    fi
done

