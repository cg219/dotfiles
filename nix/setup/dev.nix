{ pkgs, lib, ... }:
{
    environment.systemPackages = [
        pkgs.podman
        pkgs.neovim
        pkgs.git-extras
        pkgs.gitflow
        pkgs.mas
        pkgs.lua
        pkgs.lazygit
        pkgs.libfido2
        pkgs.turso-cli
        pkgs.android-tools
        pkgs.cron
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
            "alfred";
            "hoppscotch";
            "balenaetcher";
            "sublime-text";
            "sublime-merge";
            "font-ubuntu-mono-nerd-font";
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
}