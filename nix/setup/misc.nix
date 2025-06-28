{ pkgs, lib, ... }:
{
    environment.systemPackages = [
        pkgs.tree
        pkgs.tldr
        pkgs.bat
    ];

    homebrew = {
        enable = true;
        brews = [
            "mpv"
            "yt-dlp"
        ];
        casks = [
            "calibre"
            "ledger-live"
            "rightfont"
            "sf-symbols"
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
