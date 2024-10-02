#!/bin/bash

# https://repost.aws/questions/QUNJeF_ja_Suykous7EvfX5Q/aws-client-vpn-on-ubuntu-22-04

envFix="DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1"

legacySsl(){
  wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
  sudo dpkg -i libssl1.1_1.1.0g-2ubuntu4_amd64.deb
  rm libssl1.1_1.1.0g-2ubuntu4_amd64.deb
}

awsClient(){
  curl https://d20adtppz83p9s.cloudfront.net/GTK/latest/awsvpnclient_amd64.deb -o awsvpnclient_amd64.deb
  sudo dpkg -i awsvpnclient_amd64.deb
  rm awsvpnclient_amd64.deb
}

patchSystemd(){
  sudo sed -i -E "s|User=root|User=root\nEnvironment=${envFix}|g" "/etc/systemd/system/awsvpnclient.service"
  sudo systemctl daemon-reload
  sudo systemctl start awsvpnclient.service
  systemctl status awsvpnclient.service --no-pager
}

launch(){
  export ${envFix}
  /opt/awsvpnclient/AWS\ VPN\ Client %u
}

if [[ "$1" == "install" ]]; then
  awsClient
  legacySsl
  patchSystemd
else
  launch
fi
