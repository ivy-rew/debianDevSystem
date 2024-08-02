#!/bin/bash

# https://www.charlesproxy.com/documentation/installation/apt-repository/

wget -qO- https://www.charlesproxy.com/packages/apt/charles-repo.asc | sudo tee /etc/apt/keyrings/charles-repo.asc 
sudo sh -c 'echo deb [signed-by=/etc/apt/keyrings/charles-repo.asc] https://www.charlesproxy.com/packages/apt/ charles-proxy main > /etc/apt/sources.list.d/charles.list'

sudo apt update
sudo apt install -y charles-proxy
