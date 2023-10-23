echo "Installing Deno..."
curl -fsSL https://deno.land/install.sh | sh

echo "Install nodeJS..."
fnm install 20
fnm install lts/hydrogen
fnm install lts/gallium
fnm alias lts/hydrogen lts
fnm alias lts/gallium legacy
fnm alias 20 latest

source ~/.bash_profile

echo "Setting up nodeJS environments..."
npm_installs="firebase-tools ghost-cli nativescript nodemon parcel-bundler vercel jshint eslint eslint_d pkg ganache-cli"
fnm use lts
npm i -g $npm_installs
fnm use legacy
npm i -g $npm_installs
fnm use latest
npm i -g $npm_installs

source ~/.bash_profile
