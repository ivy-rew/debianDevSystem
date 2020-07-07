#!/bin/bash

# to run this script use: bash <(curl -Ls -w %{url_effective} https://tinyurl.com/vhhm3zz)

# turn of akward mouse acceleartion: otherwise host is hard to handle using VNC mouse
defaults write .GlobalPreferences com.apple.mouse.scaling -1

# enable ssh
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist

# enable vnc/screen sharing
sudo defaults write /var/db/launchd.db/com.apple.launchd/overrides.plist com.apple.screensharing -dict Disabled -bool false
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist

# close terminal on exit function
plutil -replace "Window Settings".Basic.shellExitAction -integer 1 ~/Library/Preferences/com.apple.Terminal.plist

# prefer bash over akward 'zsh': mainly for .bash_profile and .bashrc support
chsh -s /bin/bash

#homewbrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## homebrew:formulae
brew install wget
brew install htop

## homebrew:casks
brew cask install firefox

#auto-boot configurator
brew cask install clover-configurator

# jdk 11
brew cask install homebrew/cask-versions/java11

# maven
brew install mvnvm

# git
brew install git

git config --global core.editor nano