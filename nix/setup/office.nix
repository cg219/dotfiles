{ pkgs, lib, ... }:
{
    environment.systemPackages = [
        pkgs.mas
        pkgs.bruno
        pkgs.tableplus
        pkgs.obsidian
        pkgs.slack
        pkgs.spotify
        pkgs.nodejs
        pkgs.tailscale
    ];

    homebrew = {
        enable = true;
        casks = [
            "alfred"
            "arc"
            "hoppscotch"
            "notion-calendar"
            "sublime-text"
            "rightfont"
            "sf-symbols"
            "font-ubuntu-mono-nerd-font"
            "vlc"
        ];
        caskArgs.appdir = "/Applications/Homebrew Apps";
        masApps = {
            "Magnet" = 441258766;
            "Bitwarden" = 1352778147;
        };
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        onActivation.cleanup = "uninstall";
    };
}
