echo "Getting user info got git..."
read -p "Enter Name: " full_name
read -p "Enter Email: " email

echo "Creating SSH Key..."

ssh-keygen -t ed25519 -b 4096 -C $email

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
