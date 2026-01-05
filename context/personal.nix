{ config, lib, pkgs, ... }:

{
  home.file.".face".source = ../config/face/personal.jpg;
  home.file.".gitconfig".source = ../config/git/gitconfig;
}
