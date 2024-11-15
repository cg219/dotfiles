#!/usr/bin/env zsh

session=$(tmux ls | fzf | sed 's/:.*//')

if [[ -n $session ]]; then
    tmux switch-client -t "$session"
fi

