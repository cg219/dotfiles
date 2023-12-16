read -p "Enter Name: " full_name
read -p "Enter Email: " email

echo "Creating SSH Key..."

ssh-keygen -t ed25519 -b 4096 -C "github" -f ~/.ssh/github_ed25519

echo "Public Key Created ..."
echo "Adding public key to ssh-agent..."

eval "$(ssh-agent -s)"

f="Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/github_ed25519"

echo "$f" >> ~/.ssh/config

ssh-add -K ~/.ssh/github_ed25519

cat ~/.ssh/github_ed25519.pub | pbcopy

echo "SSH public key has been copied to clipboard"
echo "Paste this public key into Github settings"

open https://github.com/settings/keys
