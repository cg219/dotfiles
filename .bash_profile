for file in ~/dotfiles/terminal/bash/*(N);
do
    if [ -f "$file" ]; then source $file; fi
done

for file in ~/dotfiles/terminal/all/*(N);
do
    if [ -f "$file" ]; then source $file; fi
done

export GOPATH=$HOME/development/go
export DENO_INSTALL=$HOME/.deno
export SDKS=$HOME/sdks
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

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

export PATH=$PATH

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fnm env)"
# . "$HOME/.cargo/env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f $SDKS/google-cloud-sdk/path.bash.inc ]; then . $SDKS/google-cloud-sdk/path.bash.inc; fi

# The next line enables shell command completion for gcloud.
if [ -f $SDKS/google-cloud-sdk/completion.bash.inc ]; then . $SDKS/google-cloud-sdk/completion.bash.inc; fi
