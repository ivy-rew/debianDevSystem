#!/bin/bash

mver=3.9.8

wget https://dlcdn.apache.org/maven/maven-3/${mver}/binaries/apache-maven-${mver}-bin.tar.gz
tar xzvf apache-maven-${mver}-bin.tar.gz
sudo mv apache-maven* /opt/

sudo update-alternatives\
 --install /usr/local/bin/mvn mvn /opt/apache-maven-${mver}/bin/mvn 1000
