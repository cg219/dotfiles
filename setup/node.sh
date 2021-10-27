echo "Install nodeJS..."
fnm install 16
fnm install lts/fermium
fnm install lts/erbium
fnm alias lts/fermium lts
fnm alias lts/erbium legacy
fnm alias 16 latest

source ~/.bash_profile

echo "Setting up nodeJS environments..."
npm_installs="firebase-tools ghost-cli nativescript nodemon parcel-bundler vercel jshint eslint eslint_d pkg"
fnm use lts
npm i -g $npm_installs
fnm use legacy
npm i -g $npm_installs
fnm use latest
npm i -g $npm_installs

source ~/.bash_profile
