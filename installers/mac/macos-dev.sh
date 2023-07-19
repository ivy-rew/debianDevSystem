#!/bin/bash

# to run this script use: bash <(curl -Ls -w %{url_effective} https://tinyurl.com/vhhm3zz)


# enable ssh: you may choose to run just this line ... and run everything else from remote
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist

# turn of akward mouse acceleartion: otherwise host is hard to handle using VNC mouse
defaults write .GlobalPreferences com.apple.mouse.scaling -1

# enable vnc/screen sharing
sudo defaults write /var/db/launchd.db/com.apple.launchd/overrides.plist com.apple.screensharing -dict Disabled -bool false
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist

# close terminal on exit function
plutil -replace "Window Settings".Basic.shellExitAction -integer 1 ~/Library/Preferences/com.apple.Terminal.plist

# prefer bash over akward 'zsh': mainly for .bash_profile and .bashrc support
chsh -s /bin/bash

#homewbrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## homebrew:formulae
brew install wget
brew install htop
brew install tree

## homebrew:casks
brew install --cask firefox
brew tap homebrew/cask-versions
brew install --cask temurin17

#auto-boot configurator
brew install --cask opencore-configurator

# maven
brew install mvnvm

# git
brew install git

git config --global core.editor nano