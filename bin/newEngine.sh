#!/bin/bash  

JOB=Trunk_All
if [ ! -z "$1" ]
  then
    JOB=$1
fi

JSON=`curl -s "http://zugprobldmas/job/$JOB/lastSuccessfulBuild/api/json?pretty=true"`
ZIP=`echo $JSON | jq -r '.artifacts[].fileName' | grep 'AxonIvyEngine[0-9\.]*_All_x64.zip'`
REVISION=`echo $ZIP | grep -oP '[0-9]{5}'`
echo "found revision $REVISION"

PATH=`echo $JSON | jq -r '.artifacts[].relativePath' | grep 'AxonIvyEngine[0-9\.]*_All_x64.zip'`
URL=http://zugprobldmas/job/$JOB/lastSuccessfulBuild/artifact/$PATH
NEWZIP=`/usr/bin/wget $URL -P /tmp | grep 'saving to:.*'`
echo $NEWZIP

echo "Downloaded $ZIP. Enter a description for this engine"
read DESCRIPTION


UNPACKED=/mnt/data/axonIvyProducts/engine_$REVISION-$DESCRIPTION
echo "Extracting to $UNPACKED"
time /usr/bin/unzip -q "/tmp/$ZIP" -d $UNPACKED
`/usr/bin/nemo $UNPACKED`
