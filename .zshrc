# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/mentegee/.zsh/completions:"* ]]; then export FPATH="/home/mentegee/.zsh/completions:$FPATH"; fi
export ZSH="$HOME/.oh-my-zsh";

PATH="$PATH:/opt/homebrew/bin"
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$SDKS"
PATH="$PATH:$DENO_INSTALL/bin"
PATH="$PATH:$NPM_INSTALL/bin"
PATH="$PATH:$CUSTOM_INSTALL"
PATH="$PATH:$HOME/.cargo/bin"
export PATH

function hidefiles(){
    defaults write com.apple.finder AppleShowAllFiles NO;
    killall Finder /System/Library/CoreServices/Finder.app
}

function showfiles(){
    defaults write com.apple.finder AppleShowAllFiles YES;
    killall Finder /System/Library/CoreServices/Finder.app
}

function dk() {
    docker rm -f $1;
}

alias switch="sudo darwin-rebuild switch --flake ~/dotfiles/nix/#dev-macOS"
alias mente="cd ~"
alias web="cd ~/websites"
alias dev="cd ~/development"
alias vim="nvim"
alias n="nvim ."
# alias gateo="sudo spctl --master-disable"
# alias gatec="sudo spctl --master-enable"
# alias getssh="cat ~/.ssh/id_rsa.pub | pbcopy"
alias ".."="cd ../"
alias "..."="cd ../../"
alias gomit="git commit -m"
alias today="git log --pretty=\"· %s\" --author='Mente' --since=\"5am\" --no-merges --all"
alias yesterday="git log --pretty=\"· %s\" --author='Mente' --since=\"yesterday\" --no-merges --all"
alias obsidian="$HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents && n"
alias f="deno run -A --no-lock ~/.scripts/launchproject.ts"
# alias recode="deno --no-lock --allow-run -RW ~/.scripts/recode.ts < recode.yaml"
# alias zj="zellij a $(zellij list-sessions -rs | head -n 1)"
alias dcl="docker context use desktop-linux"
alias ds="docker ps"
alias dcd="docker compose down"
alias dcu="docker compose up -d"
alias dcub="docker compose up -d --build"

ZSH_THEME="gnzh"
plugins=(git direnv)
source $ZSH/oh-my-zsh.sh
eval $(ssh-agent) >> /dev/null
ssh-add ~/.ssh/github_ed25519 2>> /dev/null

# Initialize zsh completions (added by deno install script)
autoload -Uz compinit
compinit
. "$HOME/.deno/env"

# fnm
FNM_PATH="/home/mentegee/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
