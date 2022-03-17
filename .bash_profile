for file in ~/dotfiles/terminal/*
do
    source $file
done

export GOPATH=$HOME/development/go
export DENO_INSTALL=$HOME/.deno

PATH="$PATH:/usr/local/mysql/bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:~/bin"
PATH="$PATH:/usr/local/bin:/usr/local/sbin"
PATH="$PATH:~/.fnm"
PATH="$PATH:$GOPATH/bin"
PATH="$DENO_INSTALL/bin:$PATH"

export PATH=$PATH

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fnm env)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mentegee/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/mentegee/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mentegee/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/mentegee/Downloads/google-cloud-sdk/completion.bash.inc'; fi
