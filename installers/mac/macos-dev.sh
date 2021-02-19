#!/bin/bash

# to run this script use: bash <(curl -Ls -w %{url_effective} https://tinyurl.com/vhhm3zz)

# turn of akward mouse acceleartion: otherwise host is hard to handle using VNC mouse
sudo defaults write .GlobalPreferences com.apple.mouse.scaling -1

# enable ssh
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist

# enable vnc/screen sharing
sudo defaults write /var/db/launchd.db/com.apple.launchd/overrides.plist com.apple.screensharing -dict Disabled -bool false
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist

# show me the real world of my disK
sudo defaults write com.apple.finder AppleShowAllFiles true
sudo killall Finder

# prefer bash over akward 'zsh': mainly for .bash_profile and .bashrc support
chsh -s /bin/bash

#homewbrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## homebrew:formulae
brew install wget
brew install htop
brew install tree

## homebrew:casks
brew install --cask firefox

#auto-boot configurator
brew install --cask opencore-configurator

# maven
brew install mvnvm

# git
brew install git

git config --global core.editor nano