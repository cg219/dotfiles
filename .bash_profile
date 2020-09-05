for file in ~/dotfiles/terminal/*
do
    source $file
done

PATH="$PATH:/usr/local/mysql/bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:~/bin"
PATH="$PATH:/usr/local/bin:/usr/local/sbin"
PATH="$PATH:~/.fnm"

if test $(which fnm)
then
    eval "$(fnm env --multi)"
fi

export PATH=$PATH
