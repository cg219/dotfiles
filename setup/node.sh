echo "Install nodeJS..."
fnm install latest
fnm install latest-erbium
fnm install latest-dubnium
fnm alias latest-erbium lts
fnm alias latest-dubnium legacy
fnm default latest

source ~/.bash_profile

echo "Setting up nodeJS environments..."
npm_installs="firebase-tools ghost-cli nativescript nodemon parcel-bundler vercel"
fnm use lts
npm i -g $npm_installs
fnm use legacy
npm i -g $npm_installs
fnm use latest
npm i -g $npm_installs

source ~/.bash_profile
