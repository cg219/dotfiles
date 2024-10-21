export GOPATH="$HOME/go"
export DENO_INSTALL=$HOME/.deno
export SDKS=$HOME/sdks
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export CHARM_HOST=localhost
export FZF_DEFAULT_OPTS='--tmux'

PATH="$PATH:/usr/local/mysql/bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:$HOME/bin"
PATH="$PATH:/usr/local/bin:/usr/local/sbin"
PATH="$PATH:$HOME/.fnm"
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$DENO_INSTALL/bin"
PATH="$PATH:$SDKS"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/Library/Application Support/edgedb/bin"

. "$HOME/.cargo/env"

export PATH=$PATH
