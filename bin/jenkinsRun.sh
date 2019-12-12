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
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ENV="$DIR/.env"
if [ -f $ENV ]; then
    source $ENV
else
    echo "'$ENV' file missing. Adapt it form '.env.template' in order to use all features of jenkins CLI"
fi


# ensure dependent binaries exist
if ! [ -x "$(command -v curl)" ]; then
  sudo apt install -y curl
fi
if ! [ -x "$(command -v jq)" ]; then
  sudo apt install -y jq
fi

# color constants
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function getAvailableBranches()
{
  JSON=`curl -s "$URL/api/json?tree=jobs[name]"`
  BRANCHES=`echo $JSON | jq '.jobs[].name' \
   | sed -e 's|%2F|/|' \
   | sed -e 's|"||g' `
  echo -e $BRANCHES
}

function getAvailableTestJobs()
{
  JSON=`curl -s "http://$JENKINS/api/json?tree=jobs[name]"`
  JOBS=`echo $JSON | jq '.jobs[].name' | grep 'ivy-core_test' \
   | sed -e 's|%2F|/|' \
   | sed -e 's|"||g' `
  echo $JOBS
}

function triggerBuilds() {
    BRANCH=$1
    echo -e "triggering builds for ${GREEN}${BRANCH}${NC}"

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

    JOBS=$( getAvailableTestJobs )
    select RUN in none getDesigner getEngine 'ivy-core_ci' 'ivy-core_product' $JOBS 'new view'
    do
        BRANCH_ENCODED=`encodeForDownload $BRANCH`
        if [ "$RUN" == "none" ]
        then
            break
        fi
        if [ "$RUN" == "getDesigner" ]
        then
            $($DIR/newDesigner.sh "$BRANCH_ENCODED")
            break
        fi
        if [ "$RUN" == "getEngine" ]
        then
            $($DIR/newEngine.sh "$BRANCH_ENCODED")
            break
        fi
        if [ "$RUN" == "new view" ]
        then
            createView $BRANCH
            break
        fi
        RUN_JOB=${RUN}
        BUILD_URL="http://$JENKINS/job/$RUN_JOB/job/$BRANCH_ENCODED/build?delay=0sec"
        RESPONSE=`curl --write-out %{http_code} --silent --output /dev/null -I -X POST -u "$JENKINS_USER:$JENKINS_TOKEN" "$BUILD_URL" -H "$CRUMB"`
        echo "jenkins returned HTTP code : $RESPONSE"
        
        if [ "$RESPONSE" == 404 ] ; then
            # job may requires a manual rescan to expose our new branch
            rescanBranches "http://$JENKINS/job/$RUN_JOB/"
        fi
    done
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

function createView()
{
  # prepare a simple view: listing all jobs of my feature branch
  BRANCH=$1
  BRANCH_ENCODED=`encode $BRANCH`
  MYVIEWS_URL="https://$JENKINS/user/${JENKINS_USER}/my-views"
  curl -k -X POST -u "$JENKINS_USER:$JENKINS_TOKEN" -H "$CRUMB" --form name=test --form   mode=hudson.model.ListView --form json="{'name': '${BRANCH}', 'mode': 'hudson.model.ListView', 'useincluderegex': 'on'}" "${MYVIEWS_URL}/createView"
  CONFIG_URL="${MYVIEWS_URL}/view/${BRANCH_ENCODED}/config.xml"
  curl -k -s -X GET "${CONFIG_URL}" -o viewConf.xml
  ISSUE_REGEX=$( echo $BRANCH | sed -e 's|.*/|\.*|')
  sed -e "s|<recurse>false</recurse>|<includeRegex>${ISSUE_REGEX}</includeRegex><recurse>true></recurse>|" viewConf.xml > viewConf2.xml
  curl -k -X POST "${CONFIG_URL}" -u "$JENKINS_USER:$JENKINS_TOKEN" -H "$CRUMB" -H "Content-Type:text/xml" --data-binary "@viewConf2.xml"
  rm viewConf*.xml
  echo "View created: ${MYVIEWS_URL}/view/${BRANCH_ENCODED}/"
}

function encode()
{
  echo $1 | sed -e 's|/|%2F|' 
}

function encodeForDownload()
{
  echo $1 | sed -e 's|/|%252F|' 
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
        triggerBuilds ${BRANCH_SELECTED}
        break
    fi
done

