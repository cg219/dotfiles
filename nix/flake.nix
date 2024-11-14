{
    description = "Mente Gee mocOS system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        darwin.url = "github:LnL7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
        brew-core.url = "github:homebrew/homebrew-core";
        brew-core.flake = false;
        brew-cask.url = "github:homebrew/homebrew-cask";
        brew-cask.flake = false;
        brew-charm.url = "github:charmbracelet/homebrew-tap";
        brew-charm.flake = false;
        brew-ethereum.url = "github:ethereum/homebrew-ethereum";
        brew-ethereum.flake = false;
        brew-turso.url = "github:tursodatabase/homebrew-tap";
        brew-turso.flake = false;
    };

    outputs = inputs@{ self, darwin, nixpkgs, nix-homebrew, brew-turso, brew-core, brew-cask, brew-charm, brew-ethereum, home-manager }:
        let configuration = { pkgs, config, ... }: {
            nixpkgs.config.allowUnfree = true;
            environment.systemPackages = [];

            homebrew = {
                enable = true;
                brews = [
                    "tursodatabase/tap/turso"
                ];
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
                    "Enchanted" = -2115666285;
                };
                onActivation.autoUpdate = true;
                onActivation.upgrade = true;
                onActivation.cleanup = "uninstall";
            };

            # Auto upgrade nix package and the daemon service.
            services.nix-daemon.enable = true;
            nix.package = pkgs.nix;

            # Necessary for using flakes on this system.
            nix.settings.experimental-features = ["nix-command" "flakes"];

            programs.zsh.enable = true;  # default shell on catalina

            # programs.tmux.enable = true;
            # programs.tumx.enableFzf = true;

            system.configurationRevision = self.rev or self.dirtyRev or null;

            system.stateVersion = 4;
            system.defaults.dock.autohide = true;
            system.defaults.dock.magnification = true;
            system.defaults.dock.mineffect = "scale";
            system.defaults.dock.orientation = "left";
            system.defaults.dock.tilesize = 31;
            system.defaults.dock.largesize = 96;
            system.defaults.dock.expose-group-by-app = false;
            system.defaults.dock.dashboard-in-overlay = true;
            system.defaults.NSGlobalDomain."com.apple.trackpad.forceClick" = true;
            system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = true;
            system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;
            system.defaults.".GlobalPreferences"."com.apple.mouse.scaling" = 2.5;
            system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
            system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
            system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
            system.defaults.finder.ShowPathbar = true;
            system.defaults.finder.ShowStatusBar = true;

            nixpkgs.hostPlatform = "aarch64-darwin";
            # nix.configureBuilders = true;
            # nix.useDaemon = true;
            security.pam.enableSudoTouchIdAuth = true;

            users.users.mentegee = {
                name = "mentegee";
                home = "/Users/mentegee";
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
                home.packages = [
                    pkgs.neovim
                    pkgs.git-extras
                    pkgs.gitflow
                    pkgs.strawberry
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
                    pkgs.tmux
                    pkgs.docker-compose
                    pkgs.charm-freeze
                    pkgs.skate
                    pkgs.charm
                    pkgs.gnugrep
                    pkgs.nodejs_22
                    pkgs.ffmpeg
                    pkgs.deno
                    pkgs.darwin.trash
                    pkgs.direnv
                    pkgs.tailscale
                    pkgs.ollama
                ];
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
                    tmux = {
                        enableShellIntegration = true;
                    };
                    enableZshIntegration = true;
                };

                programs.zsh = {
                    enable = true;
                    shellAliases = {
                        switch = "darwin-rebuild switch --flake ~/dotfiles/nix/#dev-macOS";
                        mente = "cd ~";
                        desk = "cd ~/Desktop";
                        web = "cd ~/websites";
                        dev = "cd ~/development";
                        apps = "cd ~/apps";
                        vim = "nvim";
                        n = "nvim .";
                        gateo = "sudo spctl --master-disable";
                        gatec = "sudo spctl --master-enable";
                        getssh = "cat ~/.ssh/id_rsa.pub | pbcopy";
                        ".." = "cd ../";
                        "..." = "cd ../../";
                        gin = "git init";
                        gad = "git add";
                        gomit = "git commit -m";
                        gush = "git push";
                        gull = "git pull";
                        gsus = "git status";
                        today = "git log --pretty=\"· %s\" --author='Clemente' --since=\"5am\" --no-merges --all";
                        yesterday = "git log --pretty=\"· %s\" --author='Clemente' --since=\"yesterday\" --no-merges --all";
                        obsidian = "$HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents && n";
                        f = "findproject";
                        fs = "fuzzysession";
                    };

                    oh-my-zsh = {
                        enable = true;
                        theme = "gnzh";
                        plugins = [ "git" "direnv" ];
                    };

                    sessionVariables = {
                        GOPATH = "$HOME/go";
                        DENO_INSTALL = "$HOME/.deno";
                        CUSTOM_INSTALL = "$HOME/.bin";
                        NPM_INSTALL = "$HOME/.npm_global";
                        SDKS = "$HOME/sdks";
                        USE_GKE_GCLOUD_AUTH_PLUGIN = "True";
                        CHARM_HOST = "localhost";
                        FZF_DEFAULT_OPTS = "--tmux";
                    };

                    envExtra = ''
                        PATH="$PATH:/opt/homebrew/bin"
                        PATH="$PATH:$GOPATH/bin"
                        PATH="$PATH:$SDKS"
                        PATH="$PATH:$DENO_INSTALL/bin"
                        PATH="$PATH:$NPM_INSTALL/bin"
                        PATH="$PATH:$CUSTOM_INSTALL"
                        export PATH
                    '';

                    initExtra = ''
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

                        function fuzzysession() {
                            session=$(tmux ls | fzf | sed 's/:.*//')

                            if [[ -n $session ]]; then
                                tmux switch-client -t "$session"
                            fi
                        }
                    '';
                };

                programs.tmux = {
                    enable = true;
                    escapeTime = 0;
                    baseIndex = 1;
                    terminal = "screen-256color";
                    prefix = "C-a";
                    mouse = true;
                    keyMode = "vi";
                    plugins = [
                        {
                            plugin = pkgs.tmuxPlugins.sensible;
                        }
                        {
                            plugin = pkgs.tmuxPlugins.resurrect;
                        }
                        {
                            plugin = pkgs.tmuxPlugins.continuum;
                            extraConfig = "set -g @continuum-restore 'on'";
                        }
                    ];
                    extraConfig = ''
                        set -ga terminal-overrides ",screen-256color*:Tc"
                        set -g status-style "bg=#166275, fg=#ef0038"

                        bind r source-file ~/.tmux.conf
                        bind t neww
                        bind q killw
                        bind n next
                        bind w run-shell "zsh -ic fs"
                    '';
                };

                programs.kitty = {
                    enable = true;
                    settings = {
                        bold_font = "auto";
                        italic_font = "auto";
                        bold_italic_font = "auto";
                        remember_window_size = "yes";
                        background_opacity = 0.8;
                    };
                    font = {
                        name = "UbuntuMono Nerd Font Mono";
                        size = 16;
                    };
                    themeFile = "Dracula";
                };

                home.stateVersion = "24.05";

                home.file.".config/freeze" = {
                    source = config.lib.file.mkOutOfStoreSymlink ./../.config/freeze;
                    recursive =  true;
                };
                # home.file.".config/kitty" = {
                #     source = config.lib.file.mkOutOfStoreSymlink ./../.config/kitty;
                #     recursive =  true;
                # };
                # home.file.".config/nix" = {
                #     source = config.lib.file.mkOutOfStoreSymlink ./../.config/nix;
                #     recursive =  true;
                # };
                home.file.".config/nvim" = {
                    source = config.lib.file.mkOutOfStoreSymlink ./../.config/nvim;
                    recursive =  true;
                };
                # home.file.".zshenv".source = ./../.zshenv;
                # home.file.".zshrc".source = ./../.zshrc;
                # home.file.".tmux.conf".source = ./../.tmux.conf;
            };
        in
            {
            # Build darwin flake using:
            # $ darwin-rebuild build --flake .#simple
            darwinConfigurations."dev-macOS" = darwin.lib.darwinSystem {
                modules = [
                    configuration
                    nix-homebrew.darwinModules.nix-homebrew {
                        nix-homebrew = {
                            enable = false;
                            enableRosetta = false;
                            user = "mentegee";
                            autoMigrate = false;
                            mutableTaps = false;

                            taps = {
                                "homebrew/homebrew-core" = brew-core;
                                "homebrew/homebrew-cask" = brew-cask;
                                "charmbracelet/tap" = brew-charm;
                                "ethereum/ethereum" = brew-ethereum;
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
