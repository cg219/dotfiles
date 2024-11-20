{ pkgs, lib, ... }:
{
    environment.systemPackages = [
        pkgs.mas
        pkgs.discord
        pkgs.obsidian
        pkgs.spotify
        pkgs.darwin.trash
    ];

    homebrew = {
        enable = true;
        casks = [
            "affinity-designer"
            "affinity-photo"
            "affinity-publisher"
            "alfred"
            "arc"
            "calibre"
            "hoppscotch"
            "notion-calendar"
            "ledger-live"
            "dropbox"
            "vlc"
        ];
        caskArgs.appdir = "/Applications/Homebrew Apps";
        masApps = {
            "Bitwarden" = 1352778147;
        };
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        onActivation.cleanup = "uninstall";
    };
}
