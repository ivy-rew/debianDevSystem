#!/bin/bash

# https://stackoverflow.com/questions/2499794/how-to-fix-a-locale-setting-warning-from-perl#7413863

sudo sed -i 's|AcceptEnv\ LANG|#AcceptEnv\ LANG|' /etc/ssh/sshd_config
