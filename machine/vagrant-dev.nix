{ config, lib, pkgs, ... }:

{
  imports = [ ../user/spox.nix ../role/workstation.nix ../context/work.nix ];
  programs.kitty.settings.font_size = 9;
}
