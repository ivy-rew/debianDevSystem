#!/bin/bash  

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/jenkinsOp.sh"

function triggerBuilds() {
    BRANCH=$1
    echo -e "triggering builds for ${GREEN}${BRANCH}${NC}"

    JOBS=$( getAvailableTestJobs )
    select RUN in none getDesigner getEngine 'ivy-core_ci' 'ivy-core_product' $JOBS 'new view'
    do
        BRANCH_ENCODED=`encodeForDownload $BRANCH`
        if [ "$RUN" == "none" ] ; then
            break
        fi
        if [ "$RUN" == "getDesigner" ] ; then
            $($DIR/newDesigner.sh "$BRANCH_ENCODED")
            break
        fi
        if [ "$RUN" == "getEngine" ] ; then
            $($DIR/newEngine.sh "$BRANCH_ENCODED")
            break
        fi
        if [ "$RUN" == "new view" ] ; then
            createView $BRANCH
            break
        fi

        triggerBuild $RUN $BRANCH_ENCODED
    done
}

function noColor()
{
  echo -E $1 | sed -r "s/\x1B\[(([0-9]{1,2})?(;)?([0-9]{1,2})?)?[m,K,H,f,J]//g"
}

function chooseBranch()
{
  BRANCHES_RAW=$( getAvailableBranches )
  GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  BRANCHES_COLORED=$(grep -C 100 --color=always -E "${GIT_BRANCH}" <<< "${BRANCHES_RAW}")
  if [[ -z "$BRANCHES_COLORED" ]]; then
    BRANCHES_COLORED="${BRANCHES_RAW}" #all without highlight: local 'only' branch.
  fi
  readarray -t BRANCHES <<< "$BRANCHES_COLORED"
  OPTIONS=( '!re-scan' '!exit' ${BRANCHES[@]} )

  echo "SELECT branch of $URL"
  select OPTION in ${OPTIONS[@]}; do
    if [ "$OPTION" == "!re-scan" ]; then
        echo 're-scanning [beta]'
        rescanBranches $URL
        chooseBranch
        break
    fi
    if [ "$OPTION" == "!exit" ]; then
        echo 'Have a nice day! 👍'
        break
    else
        BRANCH=$(noColor "${OPTION}")
        triggerBuilds ${BRANCH}
        break
    fi
  done
}

chooseBranch


