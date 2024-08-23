#!/bin/bash

read -s _UNLOCK_PASSWORD || return
export $(echo -n "$_UNLOCK_PASSWORD" | gnome-keyring-daemon --replace --unlock)
unset _UNLOCK_PASSWORD

