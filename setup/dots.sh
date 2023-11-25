echo "Setup dotfiles..."
cd ~
git clone git@github.com:cg219/dotfiles.git
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zshenv ~/.zshenv
source ~/.zshrc
