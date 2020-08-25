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
brew install grep --with-default-names
brew install Schniz/tap/fnm

echo "Install Apps..."
brew cask install nordvpn
brew cask install sf-symbols
brew cask install alfred
brew cask install android-studio
brew cask install brave-browser
brew cask install chromium
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
brew cask install vlc

echo "Cleanup Homebrew..."
brew cleanup
