{ pkgs, lib, ... }:
{
    environment.systemPackages = [
        pkgs.tree
        pkgs.mpv
    ];

    homebrew = {
        enable = true;
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
        onActivation.cleanup = "uninstall";
    };
}
