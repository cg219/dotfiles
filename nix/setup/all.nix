{ pkgs, lib, ... }:
{
    imports = [
        ./terminal.nix
        ./personal.nix
        ./office.nix
        ./dev.nix
        ./misc.nix
    ];
}
