cd ~

echo "Setup Sublime Text..."
git clone git@github.com:cg219/sublime-settings.git
subl
osascript -e 'quit app "Sublime Text"'
trash ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
mv sublime-settings User
ln -s ~/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages

source ~/.bash_profile
