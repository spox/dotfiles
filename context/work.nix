{ config, lib, pkgs, ... }:

{
  programs.go = { goPrivate = [ "github.com/hashicorp" ]; };

  home.file.".face".source = ../config/work.jpg;
  home.file.".gitconfig".source = ../config/git/gitconfig_work;
}
