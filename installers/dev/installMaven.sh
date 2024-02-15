#!/bin/bash

wget https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz
tar xzvf apache-maven-3.9.4-bin.tar.gz
sudo mv apache-maven* /opt/

sudo update-alternatives\
 --install /usr/local/bin/mvn mvn /opt/apache-maven-3.9.4/bin/mvn\ 1000
