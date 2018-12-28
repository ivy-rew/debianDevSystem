#!/bin/bash  
JOB=Linux_Trunk_DesignerAndServer
if [ ! -z "$1" ]
  then
    JOB=$1
fi

JSON=`curl -s "http://zugprobldmas/job/$JOB/lastSuccessfulBuild/api/json?pretty=true"`
ZIP=`echo $JSON | jq -r '.artifacts[].fileName' | grep 'AxonIvyDesigner.*_Linux_x64.zip'`
REVISION=`echo $ZIP | grep -oP '[0-9]{10}'`
echo "found revision $REVISION"

PATH=`echo $JSON | jq -r '.artifacts[].relativePath' | grep 'AxonIvyDesigner.*_Linux_x64.zip'`
URL=http://zugprobldmas/job/$JOB/lastSuccessfulBuild/artifact/$PATH
NEWZIP=`/usr/bin/wget $URL -P /tmp | grep 'saving to:.*'`
echo $NEWZIP

echo "Downloaded $ZIP. Enter a description for this designer"
read DESCRIPTION


UNPACKED=/mnt/data/axonIvyProducts/designer_$REVISION-$DESCRIPTION
echo "Extracting to $UNPACKED"
/usr/bin/unzip -q "/tmp/$ZIP" -d $UNPACKED
cd $UNPACKED
`/usr/bin/nemo .`
