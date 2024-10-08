#!/bin/bash
# Fresh Dev Setup OSX

echo "Installing Homebrew..."
if test !$(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Updating Homebrew Repository..."
brew update
brew tap ethereum/ethereum

echo "Installing Tools with Homebrew..."
brew install git-extras
brew install git-flow
brew install tree
brew install wget
brew install trash
brew install mas
brew install grep
brew install fnm
brew install go
brew install nvim
brew install libfido2
brew install lua
brew install jesseduffield/lazygit/lazygit
brew tap homebrew/cask-fonts
brew tap charmbracelet/tap
brew install charmbracelet/tap/charm
brew install charmbracelet/tap/skate
brew install charmbracelet/tap/freeze
brew install tursodatabase/tap/turso

echo "Install Apps..."
brew install --cask homebrew/cask-fonts/font-ubuntu-mono-nerd-font
brew install --cask sf-symbols
brew install --cask affinity-designer
brew install --cask affinity-photo
brew install --cask affinity-publisher
brew install --cask alfred
brew install --cask android-studio
brew install --cask arc
brew install --cask balenaetcher
brew install --cask bruno
brew install --cask cron
brew install --cask db-browser-for-sqlite
brew install --cask discord
brew install --cask docker
brew install --cask dropbox
brew install --cask firefox
brew install --cask iterm2
brew install --cask ledger-live
brew install --cask obsidian
brew install --cask rightfont
brew install --cask skype
brew install --cask slack
brew install --cask spotify
brew install --cask sublime-text
brew install --cask sublime-merge
brew install --cask vlc

echo "Cleanup Homebrew..."
brew cleanup
