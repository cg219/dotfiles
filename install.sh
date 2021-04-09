#!/bin/bash
# Fresh Dev Setup OSX

echo "Setting up Mac..."
echo "Getting user info got git..."
read -p "Enter Name: " full_name
read -p "Enter Email: " email

echo "Creating SSH Key..."

ssh-keygen -t rsa -b 4096 -C $email

echo "Public Key Created ..."
echo "Adding public key to ssh-agent..."

eval "$(ssh-agent -s)"

f="Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa"

echo "$f" >> ~/.ssh/config

ssh-add -K ~/.ssh/id_rsa

cat ~/.ssh/id_rsa.pub | pbcopy

echo "SSH public key has been copied to clipboard"
echo "Paste this public key into Github settings"

open https://github.com/settings/keys

read -p "Hit [Enter] to continue once public key is added..."
echo "Install Xcode Dev Tools..."
xcode-select --install

read -p "Hit [Enter] to contine once Xcode Tools completes..."
sudo xcodebuild -license
echo "Setting up git config..."

git config --global user.name $full_name
git config --global user.email $email

echo "Defaulting to bash..."
chsh -s /bin/bash

echo "Setup dotfiles..."
cd ~
git clone git@github.com:cg219/dotfiles.git
ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.bashrc ~/.bashrc
source ~/.bash_profile

echo "Installing Homebrew..."
if test !$(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "Updating Homebrew Repository..."
brew update

echo "Installing Tools with Homebrew..."
brew install git-extras
brew install git-flow
brew install tree
brew install wget
brew install trash
brew install mas
brew install grep
brew install Schniz/tap/fnm

echo "Install Apps..."
brew cask install sf-symbols
brew cask install alfred
brew cask install android-studio
brew cask install brave-browser
brew cask install chromium
brew cask install google-chrome
brew cask install cyberduck
brew cask install docker
brew cask install dropbox
brew cask install iterm2
brew cask install ledger-live
brew cask install notion
brew cask install postman
brew cask install rightfont
brew cask install sketch
brew cask install skype
brew cask install slack
brew cask install spotify
brew cask install sublime-text
brew cask install sublime-merge
brew cask install vlc

echo "Cleanup Homebrew..."
brew cleanup

echo "Install nodeJS..."
fnm install latest
fnm install latest-erbium
fnm install latest-dubnium
fnm alias latest-erbium lts
fnm alias latest-dubnium legacy
fnm default latest

source ~/.bash_profile

echo "Setting up nodeJS environments..."
npm_installs="firebase-tools ghost-cli nativescript nodemon parcel-bundler vercel jshint eslint eslint_d"
fnm use lts
npm i -g $npm_installs
fnm use legacy
npm i -g $npm_installs
fnm use latest
npm i -g $npm_installs

source ~/.bash_profile

cd ~

echo "Setup Sublime Text..."
git clone git@github.com:cg219/sublime-settings.git
subl
osascript -e 'quit app "Sublime Text"'
trash ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
mv sublime-settings User
ln -s ~/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages

source ~/.bash_profile

read -p "Hit [Enter] after you sign in to the App Store..."
echo "Install App Store apps..."
mas install 1116599239 # NordVPN
mas install 497799835 # Xcode

echo "Setup Folders..."
cd ~
mkdir websites
mkdir development
mkdir apps

echo "Setup defaults..."

sudo spctl --master-disable
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 0
defaults write com.apple.keyboard.fnState -int 1
defaults write com.apple.mouse.scaling -float 1.5
defaults write com.apple.swipescrolldirection -int 1
defaults write com.apple.trackpad.forceClick -int 1
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock "dashboard-in-overlay" -int 1
defaults write com.apple.dock "expose-group-apps" -int 0
defaults write com.apple.dock "expose-group-by-app" -int 0
defaults write com.apple.dock largesize -int 96
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock tilesize -int 31
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock mineffect -string "scale"

killall Finder


echo "All Set!!!!!"
