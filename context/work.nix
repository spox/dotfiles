{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.go.env.GOPRIVATE = [ "github.com/hashicorp" ];

  home.file.".face.icon".source = ../config/face/work.jpg;
  home.file.".gitconfig".source = ../config/git/gitconfig_work;
  home.file.".config/sway/config.d/work".source = ../config/sway/work;
}
