{ pkgs, lib, ... }:

{
    services.nix-daemon.enable = true;

    nixpkgs.hostPlatform = "aarch64-darwin";
    nix.package = pkgs.nix;
    nix.settings.experimental-features = ["nix-command" "flakes"];

    system.defaults = {
        dock = {
            autohide = true;
            autohide-delay = 0.1;
            autohide-time-modifier = 0.3;
            magnification = true;
            mineffect = "scale";
            orientation = "left";
            tilesize = 31;
            largesize = 96;
            expose-group-by-app = false;
            dashboard-in-overlay = true;
            persistent-apps = [];
            persistent-others = [
                "/Users/mentegee/Downloads"
            ];
            show-recents = false;
            launchanim = false;
        };

        NSGlobalDomain = {
            "com.apple.trackpad.forceClick" = true;
            "com.apple.keyboard.fnState" = true;
            "com.apple.swipescrolldirection" = true;
            AppleInterfaceStyle = "Dark";
            NSNavPanelExpandedStateForSaveMode = true;
            NSNavPanelExpandedStateForSaveMode2 = true;
        };

        finder.ShowPathbar = true;
        finder.ShowStatusBar = true;

        ".GlobalPreferences"."com.apple.mouse.scaling" = 2.5;

        screencapture.type = "jpg";
        screencapture.location = "~/Dropbox/System/screenshots";

        controlcenter.Bluetooth = true;
        controlcenter.AirDrop = true;
    };


    users.users.mentegee = {
        name = "mentegee";
        home = "/Users/mentegee";
        shell = pkgs.zsh;
    };

    system.configurationRevision = self.rev or self.dirtyRev or null;
    system.stateVersion = 4;
    security.pam.enableSudoTouchIdAuth = true;
}
