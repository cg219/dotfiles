#!/bin/bash
# Fresh Dev Setup OSX

echo "Setting up Mac..."
source ./setup/ssh.sh

read -p "Hit [Enter] to continue once public key is added..."
echo "Install Xcode Dev Tools..."
xcode-select --install

read -p "Hit [Enter] to contine once Xcode Tools completes..."
echo "Setting up git config..."

git config --global user.name $full_name
git config --global user.email $email

source ./setup/dots.sh
source ./setup/brew.sh
source ./setup/node.sh
source ./setup/subl-osx.sh
source ./setup/appstore.sh
source ./setup/workspace.sh
source ./setup/defaults-osx.sh

echo "All Set!!!!!"
