#!/bin/bash  
JOB=ivy-core_product
if [ ! -z "$2" ]
  then
    JOB=$2
fi

JENKINS=$1
BRANCH=$3
ARTIFACT=$4
ARTIFACT_PATTERN=$5

DATA_DIRECTORY=~/Downloads

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ENV="$DIR/.env"
if [ -f $ENV ]; then
    source $ENV
fi

function jenkinsGet (){
    SUCCESS_URL="http://$JENKINS/job/$JOB/job/$BRANCH/lastSuccessfulBuild"
    JSON=$(curl -s "$SUCCESS_URL/api/json?pretty=true")
    REL_PATH=$(echo $JSON | \
        grep -o '"relativePath" : "[^"]*"' | \
        grep -o "[^\"]*${ARTIFACT_PATTERN}")
    ZIP=$(basename "$REL_PATH")
    REVISION=$(echo $ZIP | grep -oP '[0-9]{10}')
    echo "found revision $REVISION"

    DL_URL=$SUCCESS_URL/artifact/$REL_PATH
    wget "$DL_URL" -P /tmp
    echo "Downloaded $ZIP. Enter a description for this $ARTIFACT"
    if [ "$BRANCH" == "master" ]
      then
        read PRODUCT_DESCRIPTOR
      else
        BRANCH_DECODED=$(echo $BRANCH | sed -e 's|%252F|/|g')
        PRODUCT_DESCRIPTOR=$(basename "$BRANCH_DECODED")
    fi

    UNPACKED="${DATA_DIRECTORY}/${ARTIFACT}_$REVISION-$PRODUCT_DESCRIPTOR"
    echo "Extracting to $UNPACKED"
    unzip -q "/tmp/$ZIP" -d "$UNPACKED"
    gtk-launch "$(xdg-mime query default inode/directory)" "$UNPACKED"
}

