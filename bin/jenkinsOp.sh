#!/bin/bash  

SELECT=$1

JOB=ivy-core_ci
if [ ! -z "$3" ]
  then
    JOB=$3
fi

JENKINS="jenkins.ivyteam.io"
URL="https://${JENKINS}/job/${JOB}/"
DIR="$( cd "$( dirname "$BASH_SOURCE" )" && pwd )"

ENV="$DIR/.env"
if [ -f $ENV ]; then
    . $ENV
else
    echo "'$ENV' file missing. Adapt it form '.env.template' in order to use all features of jenkins CLI"
fi

if [ -z ${JENKINS_USER} ]; then
    JENKINS_USER=`whoami`
fi

# ensure dependent binaries exist
if ! [ -x "$(command -v curl)" ]; then
  sudo apt install -y curl
fi

getAvailableBranches(){
  local JSON=$(curl -sS "${URL}/api/json?tree=jobs\[name\]")
  local BRANCHES="$(jsonField "${JSON}" "name" \
   | sed -e 's|%2F|/|' )"
  echo ${BRANCHES}
}

getAvailableTestJobs(){
  local JSON=$(curl -sS "https://$JENKINS/api/json?tree=jobs\[name\]")
  local JOBS="$(jsonField "$JSON" "name" \
   | grep 'ivy-core_product\|ivy-core_test\|ivy-core_ci' \
   | sed -e 's|%2F|/|' )"
  echo ${JOBS}
}

getHealth(){
  JOB="$1"
  BRANCH="$2"
  API_URI="https://${JENKINS}/job/${JOB}/job/${BRANCH}/api/json?tree=color"
  JSON=$(curl -sS "${API_URI}")
  COLOR=$(jsonField "${JSON}" "color")
  colorToEmo $COLOR
}

colorToEmo(){
  local COLOR=$1
  if [ -z "$COLOR" ]; then
    COLOR="❔"
  fi
  local EMO=$(echo $COLOR \
   | sed 's|yellow|⚠️|' \
   | sed 's|blue|🆗|' \
   | sed 's|red|💔|' \
   | sed 's|disabled|🔧|' \
   | sed 's|_anime|🏃🏃🏃|' \
   | sed 's|notbuilt|💤|'
   )
  echo $EMO
}

jsonField(){
  local FIELD=$2
  echo $1 | grep -o -E "\"${FIELD}\":\"([^\"]*)" | sed -e "s|\"${FIELD}\":\"||g"
}

C_GREEN="$(tput setaf 2)"
C_RED="$(tput setaf 1)"
C_YELLOW="$(tput setaf 3)"
C_OFF="$(tput sgr0)"

statusColor(){
  local STATUS=$1
  if [[ "$STATUS" == "2"* ]] ; then
    echo "${C_GREEN}${STATUS}${C_OFF}"
  elif [[ "$STATUS" == "4"* ]] ; then
    echo "${C_RED}${STATUS}${C_OFF}"
  elif [[ "$STATUS" == "3"* ]] ; then
    echo "${C_YELLOW}${STATUS}${C_OFF}"
  else
    echo -e "$STATUS"
  fi
}

triggerBuild(){
  RUN_JOB=$1
  BRANCH=$2

  JOB_URL="https://$JENKINS/job/${RUN_JOB}/job/${BRANCH}"
  RESPONSE=$( requestBuild ${JOB_URL} )
  echo -e "[ $( statusColor ${RESPONSE} ) ] @ $JOB_URL"
  
  if [ "$RESPONSE" == 404 ] || [ "$RESPONSE" == 409 ] ; then
      # job may requires a manual rescan to expose our new branch | isolate in sub bash to avoid conflicts!
      SCANNED=$( rescanBranches "https://$JENKINS/job/$RUN_JOB/" 3>&1 1>&2 2>&3 )
      # re-try
      RESPONSE=$( requestBuild ${JOB_URL} )
      echo -e "[ $( statusColor ${RESPONSE} ) ] @ $JOB_URL"
  fi
}

requestBuild(){
  RUN_URL=$1
  if [ -z ${JENKINS_TOKEN+x} ]; then
      echo "Jenkins API token not found as enviroment variable called 'JENKINS_TOKEN'. Therefore password for jenkins must be entered:"
      echo -n "Enter JENKINS password for $JENKINS_USER:" 
      echo -n ""
      read -s JENKINS_TOKEN
      echo ""
      export JENKINS_TOKEN="$JENKINS_TOKEN" #re-use in this cli
  fi

  # get XSS preventention token
  if [ -z ${CRUMB+x} ]; then
    ISSUER_URI="https://${JENKINS}/crumbIssuer/api/xml"
    CRUMB=$(curl -sS --basic -u "${JENKINS_USER}:${JENKINS_TOKEN}" "$ISSUER_URI") \
      | grep -o -E '"crumb":"[^"]*' | sed -e 's|"crumb":"||'
    export CRUMB="$CRUMB" #re-use for follow up requests
  fi

  local RUN_PARAMS=(-L -X POST)
  RUN_PARAMS+=(--write-out %{http_code} --silent --output /dev/null)
  if [[ "${RUN_URL}" = *ivy-core_product* ]]; then
    # always build a mac for me :)
    RUN_PARAMS+=(--form "json={'parameter': {'name': 'mvnParams', 'value': '-Pivy.package.mac64'}}")
  fi
  RUN_PARAMS+=(-u "$JENKINS_USER:$JENKINS_TOKEN")

  STATUS=$(curl "${RUN_PARAMS[@]}" "$RUN_URL/build?delay=0sec" -H "$CRUMB")
  echo $STATUS
}

rescanBranches(){
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
    echo "failed: Jenkins returned $( statusColor $HTTP_STATUS )"
  fi
  printf "\n"
}

createView(){
  # prepare a simple view: listing all jobs of my feature branch
  BRANCH=$1
  BRANCH_NAME=$( echo $BRANCH | sed -e 's|/|_|')
  ISSUE_REGEX=$( echo ".*${BRANCH}" | sed -e 's|.*/|\.*|' )
  MYVIEWS_URL="https://$JENKINS/user/${JENKINS_USER}/my-views"
  curl -sS -k -X POST -u "$JENKINS_USER:$JENKINS_TOKEN" -H "$CRUMB" \
    --form name="${BRANCH_NAME}" --form   mode=hudson.model.ListView \
    --form json="{'name': '${BRANCH_NAME}', 'mode': 'hudson.model.ListView', 'useincluderegex': 'on', 'includeRegex': '${ISSUE_REGEX}', 'recurse': 'true'}" \
    "${MYVIEWS_URL}/createView"
  echo "View created: ${MYVIEWS_URL}/view/${BRANCH_NAME}/"
}

encode(){
  echo $1 | sed -e 's|/|%2F|' 
}

encodeForDownload(){
  echo $1 | sed -e 's|/|%252F|' 
}
