{
    description = "Mente Gee mocOS system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
        darwin.url = "github:LnL7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
        brew-core.url = "github:homebrew/homebrew-core";
        brew-core.flake = false;
        brew-cask.url = "github:homebrew/homebrew-cask";
        brew-cask.flake = false;
    };

    outputs = inputs@{ self, darwin, nixpkgs, nix-homebrew, brew-core, brew-cask, home-manager }:
        let configuration = { pkgs, config, ... }: {
            nixpkgs.config.allowUnfree = true;
            environment.systemPackages = [
                pkgs.deno
                pkgs.podman
                pkgs.neovim
                pkgs.git-extras
                pkgs.gitflow
                pkgs.tree
                pkgs.wget
                pkgs.mas
                pkgs.go
                pkgs.lua
                pkgs.lazygit
                pkgs.libfido2
                pkgs.turso-cli
                pkgs.android-tools
                pkgs.bruno
                pkgs.cron
                pkgs.tableplus
                pkgs.discord
                pkgs.docker
                pkgs.obsidian
                pkgs.slack
                pkgs.spotify
                pkgs.mpv
                pkgs.mkalias
                pkgs.zellij
                pkgs.docker-compose
                pkgs.charm-freeze
                pkgs.skate
                pkgs.cargo
                pkgs.charm
                pkgs.gnugrep
                pkgs.nodejs
                pkgs.ffmpeg
                pkgs.darwin.trash
                pkgs.direnv
                pkgs.tailscale
                pkgs.ollama
                pkgs.kitty
                pkgs.oh-my-zsh
            ];

            homebrew = {
                enable = true;
                casks = [
                    {
                        name = "affinity-designer";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "affinity-photo";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "affinity-publisher";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "alfred";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "arc";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "calibre";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "hoppscotch";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "notion-calendar";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "balenaetcher";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "firefox";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "sublime-text";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "sublime-merge";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "ledger-live";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "dropbox";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "rightfont";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "sf-symbols";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "font-ubuntu-mono-nerd-font";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                    {
                        name = "vlc";
                        args = { appdir = "/Users/mentegee/Applications"; };
                    }
                ];
                masApps = {
                    "Magnet" = 441258766;
                    "Bitwarden" = 1352778147;
                    "Enchanted" = 6474268307;
                };
                onActivation.autoUpdate = true;
                onActivation.upgrade = true;
                onActivation.cleanup = "uninstall";
            };

            # Auto upgrade nix package and the daemon service.
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

            # environment.shellAliases = {};

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

            system.activationScripts.applications.text = let
                env = pkgs.buildEnv {
                    name = "system-applications";
                    paths = config.environment.systemPackages;
                    pathsToLink = "/Applications";
                };
            in
                pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
                    ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
                '';

        };
            mentegee = {pkgs, config, ... }: {
                nixpkgs.config.allowUnfree = true;
                home.packages = [];
                programs.home-manager.enable = true;
                programs.git = {
                    enable = true;
                    userName = "Mente Gee";
                    userEmail = "dev@imkreative.com";
                    ignores = [ ".DS_STORE" ];
                    extraConfig = {
                        init.defaultBranch = "main";
                        push.autoSetupRemote = true;
                    };
                };

                programs.fzf = {
                    enable = true;
                    enableZshIntegration = true;
                };

                home.stateVersion = "24.05";
                home.enableNixpkgsReleaseCheck = false;

                home.file.".config/freeze" = {
                    source = config.lib.file.mkOutOfStoreSymlink ./../.config/freeze;
                    recursive =  true;
                };
                home.file.".config/kitty" = {
                    source = config.lib.file.mkOutOfStoreSymlink ./../.config/kitty;
                    recursive =  true;
                };
                home.file.".config/zellij" = {
                    source = config.lib.file.mkOutOfStoreSymlink ./../.config/zellij;
                    recursive =  true;
                };
                home.file.".config/nvim" = {
                    source = config.lib.file.mkOutOfStoreSymlink ./../.config/nvim;
                    recursive =  true;
                };
                home.file.".scripts" = {
                    source = config.lib.file.mkOutOfStoreSymlink ./../scripts;
                    recursive = false;
                };
                # home.file.".zshenv".source = ./../.zshenv;
                # home.file.".zshrc".source = ./../.zshrc;
            };
        in
            {
            # Build darwin flake using:
            # $ darwin-rebuild build --flake .#simple
            darwinConfigurations."dev-macOS" = darwin.lib.darwinSystem {
                specialArgs = { inherit inputs; };
                modules = [
                    configuration
                    ./configuration.nix
                    nix-homebrew.darwinModules.nix-homebrew {
                        nix-homebrew = {
                            enable = true;
                            enableRosetta = false;
                            user = "mentegee";
                            autoMigrate = true;
                            mutableTaps = true;

                            taps = {
                                "homebrew/homebrew-core" = brew-core;
                                "homebrew/homebrew-cask" = brew-cask;
                            };
                        };
                    }
                    home-manager.darwinModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.mentegee = mentegee;
                    }
                ];
            };

            # Expose the package set, including overlays, for convenience.
            darwinPackages = self.darwinConfigurations."dev-macOS".pkgs;
        };
}
