#!/bin/bash

mver=3.9.14

base=https://archive.apache.org/dist/maven/maven-3/${mver}/binaries
wget ${base}/apache-maven-${mver}-bin.tar.gz
tar xzvf apache-maven-${mver}-bin.tar.gz
sudo mv apache-maven* /opt/

sudo update-alternatives\
 --install /usr/local/bin/mvn mvn /opt/apache-maven-${mver}/bin/mvn 1000
