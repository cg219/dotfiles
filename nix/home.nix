{ pkgs, config, ... }:
{
    nixpkgs.config.allowUnfree = true;
    home.packages = [];
    programs.home-manager.enable = true;
    programs.git = {
        enable = true;
        userName = "Mente Gee";
        userEmail = "dev@imkreative.com";
        ignores = [ ".DS_STORE" ];
        extraConfig = {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
        };
    };

    programs.fzf = {
        enable = true;
        enableZshIntegration = true;
    };

    home.stateVersion = "24.11";
    home.enableNixpkgsReleaseCheck = false;

    home.file.".config/freeze" = {
        source = config.lib.file.mkOutOfStoreSymlink ./../.config/freeze;
        recursive =  true;
    };
    # home.file.".config/ghostty" = {
    #     source = config.lib.file.mkOutOfStoreSymlink ./../.config/ghostty;
    #     recursive =  true;
    # };
    home.file.".config/kitty" = {
        source = config.lib.file.mkOutOfStoreSymlink ./../.config/kitty;
        recursive =  true;
    };
    home.file.".config/zellij" = {
        source = config.lib.file.mkOutOfStoreSymlink ./../.config/zellij;
        recursive =  true;
    };
    home.file.".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink ./../.config/nvim;
        recursive =  true;
    };
    home.file.".scripts" = {
        source = config.lib.file.mkOutOfStoreSymlink ./../scripts;
        recursive = false;
    };
}
