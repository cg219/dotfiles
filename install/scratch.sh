
#!/bin/bash
# Fresh Dev Setup OSX

source ./brew.sh
lua ./macos.lua

read -p "Hit [Enter] to continue once public key is added..."
echo "Install Xcode Dev Tools..."
xcode-select --install

read -p "Hit [Enter] to contine once Xcode Tools completes..."
sudo xcodebuild -license
echo "Setting up git config..."

git config --global user.name $full_name
git config --global user.email $email
git config --global init.defaultBranch main

echo "Setup dotfiles..."
cd ~
git clone git@github.com:cg219/dotfiles.git
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zshenv ~/.zshenv
ln -s ~/dotfiles/nvim ~/.config/
source ~/.zshrc

echo "Installing Deno..."
curl -fsSL https://deno.land/install.sh | sh

echo "Install nodeJS..."
fnm install 20
fnm install lts/hydrogen
fnm install lts/gallium
fnm alias lts/hydrogen lts
fnm alias lts/gallium legacy
fnm alias 20 latest

source ~/.zshrc

echo "Setting up nodeJS environments..."
npm_installs="firebase-tools ghost-cli nodemon jshint eslint eslint_d pkg"
fnm use lts
npm i -g $npm_installs
fnm use legacy
npm i -g $npm_installs
fnm use latest
npm i -g $npm_installs

source ~/.zshrc

cd ~

echo "Install Go mods..."
go get golang.org/x/tools/gopls@latest

source ~/.zshrc

cd ~

echo "Setup Sublime Text..."
git clone git@github.com:cg219/sublime-settings.git
subl
osascript -e 'quit app "Sublime Text"'
trash ~/Library/Application\ Support/Sublime\ Text/Packages/User
mv sublime-settings User
ln -s ~/User ~/Library/Application\ Support/Sublime\ Text/Packages

source ~/.zshrc

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
