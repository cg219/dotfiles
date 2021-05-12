read -p "Hit [Enter] to continue once public key is added..."
echo "Install Xcode Dev Tools..."
xcode-select --install

read -p "Hit [Enter] to contine once Xcode Tools completes..."
sudo xcodebuild -license
echo "Setting up git config..."

git config --global user.name $full_name
git config --global user.email $email
git config --global init.defaultBranch main
