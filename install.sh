#!/bin/bash
# Fresh Dev Setup OSX

echo "Setting up Mac..."
source ~/dotfiles/setup/ssh.sh

read -p "Hit [Enter] to continue once public key is added..."
echo "Install Xcode Dev Tools..."
xcode-select --install

read -p "Hit [Enter] to contine once Xcode Tools completes..."
echo "Setting up git config..."

git config --global user.name $full_name
git config --global user.email $email

source ~/dotfiles/setup/dots.sh
source ~/dotfiles/setup/brew.sh
source ~/dotfiles/setup/node.sh
source ~/dotfiles/setup/subl-osx.sh
source ~/dotfiles/setup/appstore.sh
source ~/dotfiles/setup/workspace.sh
source ~/dotfiles/setup/defaults-osx.sh

echo "All Set!!!!!"
