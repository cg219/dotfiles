{
    description = "Mente Gee mocOS system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        darwin.url = "github:LnL7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
        nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";
        brew-core.url = "github:homebrew/homebrew-core";
        brew-core.flake = false;
        brew-cask.url = "github:homebrew/homebrew-cask";
        brew-cask.flake = false;
        brew-hashi.url = "github:hashicorp/homebrew-tap";
        brew-hashi.flake = false;
    };

    outputs = inputs@{ self, darwin, nixpkgs, nix-homebrew, brew-core, brew-cask, brew-hashi, home-manager }:
        let configuration = { pkgs, config, ... }: {
            system.configurationRevision = self.rev or self.dirtyRev or null;

            imports = [
                ./setup/all.nix
            ];

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
                                "hashicorp/tap" = brew-hashi;
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
