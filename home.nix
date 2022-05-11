{ config, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;
    programs.home-manager.enable = true;
    imports = [
      ./role/workstation.nix
      ./user/spox.nix
    ];
}
