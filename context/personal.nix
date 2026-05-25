{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.file.".face.icon".source = ../config/face/personal.jpg;
  home.file.".gitconfig".source = ../config/git/gitconfig;
  home.file.".config/sway/config.d/personal".source = ../config/sway/personal;
}
