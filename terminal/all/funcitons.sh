function hidefiles(){
    defaults write com.apple.finder AppleShowAllFiles NO;
    killall Finder /System/Library/CoreServices/Finder.app
}

function showfiles(){
    defaults write com.apple.finder AppleShowAllFiles YES;
    killall Finder /System/Library/CoreServices/Finder.app
}

function findproject() {
    session=$(find ~/development/ActiveTheory ~/development ~/websites ~/apps ~ -type d -mindepth 1 -maxdepth 1 | fzf)
    name=$(basename "$session" | tr . _)
    
    if ! tmux has-session -t "$name" >> /dev/null ; then
        tmux new-session -s "$name" -c "$session" -d
    fi

    tmux switch-client -t "$name"
}
