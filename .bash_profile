for file in ~/dotfiles/terminal/*
do
    source $file
done

export GOPATH=$HOME/development/go

PATH="$PATH:/usr/local/mysql/bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:~/bin"
PATH="$PATH:/usr/local/bin:/usr/local/sbin"
PATH="$PATH:~/.fnm"
PATH="$PATH:$GOPATH/bin"

if test $(which fnm)
then
    eval "$(fnm env --multi)"
fi

export PATH=$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/clementegomez/google-cloud-sdk/path.bash.inc' ]; then . '/Users/clementegomez/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/clementegomez/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/clementegomez/google-cloud-sdk/completion.bash.inc'; fi
