#!/bin/bash  

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/jenkinsOp.sh"

function triggerBuilds() {
    BRANCH=$1
    local JOBS=('ivy-core_ci' 'ivy-core_product' $(getAvailableTestJobs) )
    
    COLOR_BRANCH=${C_GREEN}${BRANCH}${C_OFF}
    if [ "$HEALTH" == "true" ] ; then
        echo -e "getting health of ${COLOR_BRANCH}"
        SEL_JOBS=$(jobStatus JOBS[@] )
    else
        echo -e "triggering builds for ${COLOR_BRANCH}"
        SEL_JOBS=${JOBS[@]}
    fi
    HEALTH="false"

    select RUN in none 'health' getDesigner getEngine ${SEL_JOBS[@]} 'new view'
    do
        BRANCH_ENCODED=`encodeForDownload $BRANCH`
        if [ "$RUN" == "none" ] ; then
            break
        fi
        if [ "$RUN" == "health" ] ; then
            HEALTH="true"
            break;
        fi
        if [ "$RUN" == "getDesigner" ] ; then
            echo $($DIR/newDesigner.sh "$BRANCH_ENCODED")
            break
        fi
        if [ "$RUN" == "getEngine" ] ; then
            echo $($DIR/newEngine.sh "$BRANCH_ENCODED")
            break
        fi
        if [ "$RUN" == "new view" ] ; then
            echo "$(createView $BRANCH)"
            break
        fi

        JOB_RAW=$(sed 's|\.\.\..*||' <<< $RUN )
        echo $(triggerBuild ${JOB_RAW} $BRANCH_ENCODED)
    done
    
    if [ "$HEALTH" == "true" ] ; then
        triggerBuilds $1
    fi
}

function jobStatus()
{
    declare -a JBS=("${!1}")
    local jobState=()
    for JB in ${JBS[*]}; do
        jobState+=("$JB...$(getHealth ${JB} ${BRANCH_ENCODED})")
    done
    echo ${jobState[@]}
}

function noColor()
{
  echo -E $1 | sed -E "s/\x1B\[(([0-9]{1,2})?(;)?([0-9]{1,2})?)?[m,K,H,f,J]//g"
}

function goodbye(){
  printf "\nHave a nice day! 👍"
  inspire
}

function inspire(){
  JSON=$(curl -sS https://thatsthespir.it/api)
  QUOTE=$(jsonField "${JSON}" "quote")
  AUTHOR=$(jsonField "${JSON}" "author")
  LINK=$(jsonField "${JSON}" "id" )
  printf "\n\n$(tput bold setaf 4)${QUOTE}${C_OFF}
$(tput setaf 5)${AUTHOR} $(tput setaf 6)https://thatsthespir.it/${LINK}${C_OFF}"
}

function chooseBranch()
{
  BRANCHES_RAW=$( getAvailableBranches )
  GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  BRANCHES_COLORED=$(grep -C 100 --color=always -E "${GIT_BRANCH}" <<< "${BRANCHES_RAW[@]}")
  if [[ -z "$BRANCHES_COLORED" ]]; then
    BRANCHES_COLORED="${BRANCHES_RAW[@]}" #all without highlight: local 'only' branch.
  fi
  OPTIONS=( '!re-scan' '!exit' ${BRANCHES_COLORED[@]} )

  echo "SELECT branch of $URL"
  select OPTION in ${OPTIONS[@]}; do
    if [ "$OPTION" == "!re-scan" ]; then
        echo 're-scanning [beta]'
        rescanBranches $URL
        chooseBranch
        break
    fi
    if [ "$OPTION" == "!exit" ]; then
        break
    else
        BRANCH=$(noColor "${OPTION}")
        triggerBuilds ${BRANCH}
        break
    fi
  done
}

if [[ "$1" != "test" ]]; then
  trap goodbye EXIT
  chooseBranch
fi

