{ config, lib, pkgs, ... }:

{
  imports =
    [ ../user/spox.nix ../role/workstation.nix ../context/personal.nix ];

  systemd.user.services = {
    xmodmap = {
      Unit = {
        Description = "Cap key reconfigure";
        Requires = "graphical-session.target";
      };
      Service = {
        ExecStart = "xmodmap ${config.xdg.cacheHome}/xmodmap";
        Restart = "never";
      };
    };
  };

  xdg.configFile = { "xmodmap".source = ../config/caps-xmodmap; };
}
