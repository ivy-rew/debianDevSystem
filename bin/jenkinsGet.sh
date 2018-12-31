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

function jenkinsGet (){
    # ensure dependent binaries exist
    if ! [ -x "$(command -v curl)" ]; then
      sudo apt install -y curl
    fi
    if ! [ -x "$(command -v jq)" ]; then
      sudo apt install -y jq
    fi

    JSON=`curl -s "http://$JENKINS/job/$JOB/job/$BRANCH/lastSuccessfulBuild/api/json?pretty=true"`
    ZIP=`echo $JSON | jq -r '.artifacts[].fileName' | grep $ARTIFACT_PATTERN`
    REVISION=`echo $ZIP | grep -oP '[0-9]{10}'`
    echo "found revision $REVISION"

    PATH=`echo $JSON | jq -r '.artifacts[].relativePath' | grep $ARTIFACT_PATTERN`
    URL=http://$JENKINS/job/$JOB/job/$BRANCH/lastSuccessfulBuild/artifact/$PATH
    NEWZIP=`/usr/bin/wget $URL -P /tmp | grep 'saving to:.*'`
    echo $NEWZIP

    echo "Downloaded $ZIP. Enter a description for this $ARTIFACT"
    read DESCRIPTION


    UNPACKED="/mnt/data/axonIvyProducts/${ARTIFACT}_$REVISION-$DESCRIPTION"
    echo "Extracting to $UNPACKED"
    /usr/bin/unzip -q "/tmp/$ZIP" -d $UNPACKED
    cd $UNPACKED
    `/usr/bin/nemo .`
}

