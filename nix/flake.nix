{
    description = "Mente Gee mocOS system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        darwin.url = "github:LnL7/nix-darwin";
        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
        brew-core = {
            url = "github:homebrew/homebrew-core";
            flake = false;
        };
        brew-cask = {
            url = "github:homebrew/homebrew-cask";
            flake = false;
        };
        brew-charm = {
            url = "github:charmbracelet/homebrew-tap";
            flake = false;
        };
        brew-ethereum = {
            url = "github:ethereum/homebrew-ethereum";
            flake = false;
        };
        darwin.inputs.nixpkgs.follows = "nixpkgs";
        # home-manager.url = "github:nix-community/home-manager";
        # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, darwin, nixpkgs, nix-homebrew, brew-core, brew-cask, brew-charm, brew-ethereum }:
        let configuration = { pkgs, config, ... }: {
            nixpkgs.config.allowUnfree = true;
            # List packages installed in system profile. To search by name, run:
            # $ nix-env -qaP | grep wget
            environment.systemPackages = [
                pkgs.neovim
                pkgs.git-extras
                pkgs.gitflow
                pkgs.tree
                pkgs.wget
                pkgs.mas
                pkgs.fnm
                pkgs.go
                pkgs.lua
                pkgs.lazygit
                pkgs.libfido2
                pkgs.turso-cli
                pkgs.kitty
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
            ];

            homebrew = {
                enable = true;
                # taps = {
                #     "homebrew/homebrew-core" = brew-core;
                #     "homebrew/homebrew-cask" = brew-cask;
                #     "charmbracelet/tap" = brew-charm;
                #     "ethereum/ethereum" = brew-ethereum;
                # };
                brews = [
                    "charmbracelet/tap/charm"
                    "charmbracelet/tap/freeze"
                    "charmbracelet/tap/skate"
                    "grep"
                    "trash"
                ];
                # casks = [
                #     "affinity-designer"
                #     "affinity-photo"
                #     "affinity-publisher"
                #     "alfred"
                #     "arc"
                #     "balenaetcher"
                #     "firefox"
                #     "sublime-text"
                #     "sublime-merge"
                #     "ledger-live"
                #     "dropbox"
                #     "rightfont"
                #     "sf-symbols"
                #     "skype"
                #     "font-ubuntu-mono-nerd-font"
                #     "vlc"
                # ];
                onActivation.autoUpdate = true;
                onActivation.upgrade = true;
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
          while read src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
                    ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
                '';

            # Auto upgrade nix package and the daemon service.
            services.nix-daemon.enable = true;
            # nix.package = pkgs.nix;

            # Necessary for using flakes on this system.
            nix.settings.experimental-features = ["nix-command" "flakes"];

            # Create /etc/zshrc that loads the nix-darwin environment.
            programs.zsh.enable = true;  # default shell on catalina
            # programs.fish.enable = true;

            # programs.tmux.enable = true;
            # programs.tumx.enableFzf = true;

            # Set Git commit hash for darwin-version.
            system.configurationRevision = self.rev or self.dirtyRev or null;

            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            system.stateVersion = 4;

            # The platform the configuration will be used on.
            nixpkgs.hostPlatform = "aarch64-darwin";

            users.users.mentegee = {
                name = "mentegee";
                home = "/Users/mentegee";
            };

        };
        in
            {
            # Build darwin flake using:
            # $ darwin-rebuild build --flake .#simple
            darwinConfigurations."dev-macOS" = darwin.lib.darwinSystem {
                modules = [
                    configuration
                    nix-homebrew.darwinModules.nix-homebrew
                    {
                        nix-homebrew = {
                            enable = true;
                            enableRosetta = true;
                            user = "mentegee";
                            autoMigrate = true;
                            # mutableTaps = false;
                        };
                    }
                ];
            };

            # Expose the package set, including overlays, for convenience.
            darwinPackages = self.darwinConfigurations."dev-macOS".pkgs;
        };
}