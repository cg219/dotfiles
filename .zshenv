export GOPATH="$HOME/go"
export DENO_INSTALL=$HOME/.deno
export SDKS=$HOME/sdks
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export CHARM_HOST=localhost

PATH="$PATH:/usr/local/mysql/bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:~/bin"
PATH="$PATH:/usr/local/bin:/usr/local/sbin"
PATH="$PATH:~/.fnm"
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$DENO_INSTALL/bin"
PATH="$PATH:$SDKS"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/Library/Application Support/edgedb/bin"

. "$HOME/.cargo/env"

export PATH=$PATH
