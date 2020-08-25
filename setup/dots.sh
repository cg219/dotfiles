echo "Defaulting to bash..."
chsh -s /bin/bash

echo "Setup dotfiles..."
cd ~
git clone git@github.com:cg219/dotfiles.git
ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.bashrc ~/.bashrc
source ~/.bash_profile
