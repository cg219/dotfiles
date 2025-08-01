{ pkgs, lib, ... }:
{
    environment.systemPackages = [
        pkgs.neovim
        pkgs.mas
        pkgs.lua
        pkgs.lazygit
        pkgs.libfido2
        pkgs.turso-cli
        # pkgs.android-tools
        pkgs.docker-compose
        pkgs.charm-freeze
        pkgs.skate
        pkgs.nodejs
        pkgs.darwin.trash
        pkgs.direnv
        pkgs.ollama
        pkgs.goose
        pkgs.just
        pkgs.python3
        pkgs.ruby_3_4
    ];

    homebrew = {
        enable = true;
        casks = [
            "alfred"
            "hoppscotch"
            "balenaetcher"
            "sublime-text"
            "sublime-merge"
            "font-ubuntu-mono-nerd-font"
            # "docker"
            "hoppscotch"
            "msty"
        ];
        brews = [
            "ffmpeg"
            "hashicorp/tap/terraform"
            "tinygo"
            "avrdude"
            "cocoapods"
            "jj"
        ];
        caskArgs.appdir = "/Applications/Homebrew Apps";
        masApps = {
            "Magnet" = 441258766;
            "Bitwarden" = 1352778147;
            "Enchanted" = 6474268307;
            "Xcode" = 497799835;
        };
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        # onActivation.cleanup = "zap";
    };
}
