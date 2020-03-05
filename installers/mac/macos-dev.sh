#!/bin/bash

# to run this script use: bash <(curl -Ss https://tinyurl.com/vhhm3zz)

# turn of akward mouse acceleartion: otherwise host is hard to handle using VNC mouse
defaults write .GlobalPreferences com.apple.mouse.scaling -1

#homewbrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## homebrew:formulae
brew install wget
brew install htop

## homebrew:casks
brew cask install firefox

# jdk 11
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk11

# maven
brew install mvnvm

# git
brew install git
