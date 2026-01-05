{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
  home.username = "spox";
  home.homeDirectory = "/home/spox";
}
