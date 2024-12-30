{ pkgs, lib, ... }:
{
    environment.systemPackages = [
        pkgs.deno
        pkgs.wget
        pkgs.go
        pkgs.mkalias
        pkgs.zellij
        pkgs.cargo
        pkgs.gnugrep
        pkgs.oh-my-zsh
    ];

    environment.variables = {
        GOPATH = "$HOME/go";
        DENO_INSTALL = "$HOME/.deno";
        CUSTOM_INSTALL = "$HOME/.bin";
        NPM_INSTALL = "$HOME/.npm_global";
        SDKS = "$HOME/sdks";
        USE_GKE_GCLOUD_AUTH_PLUGIN = "True";
        CHARM_HOST = "localhost";
        FZF_DEFAULT_OPTS = "--tmux";
    };

    programs.zsh = {
        enable = true;
        enableFzfCompletion = true;
        enableFzfHistory = true;
        promptInit = '''';
        shellInit = ''
            ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh";

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

            alias switch="darwin-rebuild switch --flake ~/dotfiles/nix/#dev-macOS"
            alias mente="cd ~"
            alias desk="cd ~/Desktop"
            alias web="cd ~/websites"
            alias dev="cd ~/development"
            alias apps="cd ~/apps"
            alias vim="nvim"
            alias n="nvim ."
            alias gateo="sudo spctl --master-disable"
            alias gatec="sudo spctl --master-enable"
            alias getssh="cat ~/.ssh/id_rsa.pub | pbcopy"
            alias ".."="cd ../"
            alias "..."="cd ../../"
            alias gomit="git commit -m"
            alias today="git log --pretty=\"· %s\" --author='Mente' --since=\"5am\" --no-merges --all"
            alias yesterday="git log --pretty=\"· %s\" --author='Mente' --since=\"yesterday\" --no-merges --all"
            alias obsidian="$HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents && n"
            alias f="deno run -A ~/.scripts/launchproject.ts"
            alias zj="zellij a $(zellij list-sessions -rs | head -n 1)"

            export ZSH
            ZSH_THEME="gnzh"
            plugins=(git direnv)
            source $ZSH/oh-my-zsh.sh
        '';
    };
}
