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
            system.configurationRevision = self.rev or self.dirtyRev or null;

            imports = [
                ./setup/terminal.nix
            ];

            environment.systemPackages = [
                pkgs.podman
                pkgs.neovim
                pkgs.git-extras
                pkgs.gitflow
                pkgs.tree
                pkgs.mas
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
                pkgs.docker-compose
                pkgs.charm-freeze
                pkgs.skate
                pkgs.charm
                pkgs.nodejs
                pkgs.ffmpeg
                pkgs.darwin.trash
                pkgs.direnv
                pkgs.tailscale
                pkgs.ollama
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
                        home-manager.users.mentegee = ./home.nix;
                    }
                ];
            };

            # Expose the package set, including overlays, for convenience.
            darwinPackages = self.darwinConfigurations."dev-macOS".pkgs;
        };
}
