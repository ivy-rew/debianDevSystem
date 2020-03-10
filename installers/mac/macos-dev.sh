#!/bin/bash

# turn of akward mouse acceleration: otherwise host is hard to handle using VNC mouse
defaults write .GlobalPreferences com.apple.mouse.scaling -1

# prefer bash over akward 'zsh': mainly for .bash_profile and .bashrc support
chsh -s /bin/bash

#homewbrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## homebrew:formulae
brew install wget
brew install htop

brew install git
git config --global core.editor nano

## homebrew:casks
brew cask install firefox

#auto-boot configurator
brew cask install clover-configurator

# jdk 11
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk11

# maven
brew install mvnvm
