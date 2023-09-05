#!/bin/bash

wget https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz
tar xzvf apache-maven-3.9.4-bin.tar.gz
sudo mv apache-maven* /opt/

tee -a $HOME/.profile << EOF

# maven
M2_HOME='/opt/apache-maven-3.9.4'
PATH="\$M2_HOME/bin:\$PATH"
EOF