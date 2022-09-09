#!/bin/bash

cd /tmp

#cleanup older dwnlds
archive="postman*.tar.gz"
rm ${archive}
rm -rf Postman

wget https://dl.pstmn.io/download/latest/linux64 --content-disposition
FILE=`find ${archive}`
FILE=${FILE%.tar.gz}
VERSION=${FILE#Postman-linux-x64-}
tar -xzf ${archive}

cd /opt/postman
sudo rm -rf
TARGET=/opt/postman/$VERSION
sudo mkdir -p $TARGET
sudo ln -s $VERSION/Postman Postman

cd /tmp
#rename 
sudo mv -v Postman $TARGET # TODO: get rid of ugly sub directory!
echo installed $TARGET
rm ${archive}
