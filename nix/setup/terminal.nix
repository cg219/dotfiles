{ pkgs, lib, ... }:
{
    environment.systemPackages = [
        pkgs.wget
        pkgs.zellij
        pkgs.cargo
        pkgs.gnugrep
        pkgs.oh-my-zsh
    ];

    homebrew = {
        enable = true;
        casks = [
            "ghostty"
            "tailscale"
        ];
        brews = [
            "deno"
            "go"
        ];
        caskArgs.appdir = "/Applications/Homebrew Apps";
        masApps = {
            "Bitwarden" = 1352778147;
        };
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        onActivation.cleanup = "uninstall";
    };

    environment.variables = {
        GOPATH = "$HOME/go";
        DENO_INSTALL = "$HOME/.deno";
        CUSTOM_INSTALL = "$HOME/.bin";
        NPM_INSTALL = "$HOME/.npm_global";
        SDKS = "$HOME/sdks";
        USE_GKE_GCLOUD_AUTH_PLUGIN = "True";
        CHARM_HOST = "localhost";
        FZF_DEFAULT_OPTS = "--tmux";
        EDITOR = "nvim";
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

            function dk() {
                docker rm -f $1;
            }

            alias switch="sudo darwin-rebuild switch --flake ~/dotfiles/nix/#dev-macOS"
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
            alias f="deno run -A --no-lock ~/.scripts/launchproject.ts"
            alias recode="deno --no-lock --allow-run -RW ~/.scripts/recode.ts < recode.yaml"
            alias zj="zellij a $(zellij list-sessions -rs | head -n 1)"
            alias dcl="docker context use desktop-linux"
            alias ds="docker ps"
            alias dcd="docker compose down"
            alias dcu="docker compose up -d"
            alias dcub="docker compose up -d --build"

            export ZSH
            ZSH_THEME="gnzh"
            plugins=(git direnv)
            source $ZSH/oh-my-zsh.sh
        '';
    };
}
