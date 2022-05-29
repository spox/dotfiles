{ config, lib, pkgs, ... }:

{
  home.file.".face".source = ../config/fry.png;
  home.file.".gitconfig".source = ../config/git/gitconfig;
}
