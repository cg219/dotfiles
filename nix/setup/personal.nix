{ pkgs, lib, ... }:
{
    environment.systemPackages = [
        pkgs.mas
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
            "zen"
            "calibre"
            "notion-calendar"
            "ledger-live"
            "dropbox"
            "vlc"
            "discord"
            "obsidian"
            "spotify"
        ];
        caskArgs.appdir = "/Applications/Homebrew Apps";
        masApps = {
            "Bitwarden" = 1352778147;
        };
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        # onActivation.cleanup = "zap";
    };
}
