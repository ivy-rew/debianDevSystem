#!/bin/bash
chromium --app=https://outlook.office.com \
 --user-data-dir=$HOME/.config/chromeMailer\
 --prerender-from-omnibox=disabled\
 --site-per-process
