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
            "docker"
            "hoppscotch"
            "msty"
        ];
        brews = [
            "ffmpeg"
            "hashicorp/tap/terraform"
            "tinygo"
            "avrdude"
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
        onActivation.cleanup = "uninstall";
    };
}
