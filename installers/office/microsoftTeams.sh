#!/bin/bash

repo="https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/"
version="teams_1.3.00.958_amd64.deb"
wget "${repo}/${version}"
sudo dpkg -i "${version}"
