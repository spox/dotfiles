{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}

in {
  home.packages = with pkgs; [
    kitty
    tmux
    starship

    go
    protobuf
    awscli2
    bottom
    btop

    catimg
    direnv
    dos2unix
    du-dust
    eza
    ffmpeg
    glances
    htop
    imagemagick
    jless
    jq
    kismet
    lm_sensors

    netcat
    nethogs
    nettools
    nmap
    p7zip
    procs
    progress
    unzip
    zoxide

    bat
    bats
    coreutils
    delta
    emacs
    fd
    git
    gopls
    graphviz
    imhex
    jujutsu
    ripgrep
    shellcheck
    tig

    croc
    neofetch
    qrencode
    whois
    playerctl
    brightnessctl

    hunspell
    hunspellDicts.en-us-large
    weechat
    weechatScripts.wee-slack
    keepassxc
    krita
    librewolf
    ungoogled-chromium
    swayfx
    swayidle
    swaylock
    swaybg
    waybar
    wl-clipboard
    rofi
    rofi-emoji
    fuzzel
    grim
    wlsunset
    bemenu
    slurp
    pinentry
    pavucontrol
    pamixer
    swappy
    wf-recorder
    kanshi
    udiskie
    lxqt-policykit
    xsettingsd
    swaynotificationcenter

    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji
    unicode-emoji
    nerd-fonts.noto
    nerd-fonts.jetbrains-mono
    hack-font
    font-awesome
    fira-code
    material-symbols
  ];

  programs.bash = {
    enable = true;
    sessionVariables = {
      BROWSER = "librewolf";
      EDITOR = "emacs -nw";
      GIT_EDITOR = "emacs -nw";
      GOBIN = "~/.local/bin";
      GOPATH="~/.local/go";
      QT_QPA_PLATFORM="wayland;xcb";
      SDL_VIDEODRIVER="wayland";
      XDG_CURRENT_DESKTOP="sway";
      XDG_SESSION_DESKTOP="sway";
      XDG_SESSION_TYPE="wayland";
      MOZ_ENABLE_WAYLAND="1";
      GDK_BACKEND="wayland";
      CLUTTER_BACKEND="wayland";
      XCURSOR_THEME="Adwaita";
      XCURSOR_SIZE=24;  
    };
    initExtra = ''
      . ${config.xdg.configHome}/bash-aliases/bundler.sh
      . ${config.xdg.configHome}/bash-aliases/copypasta.sh
      . ${config.xdg.configHome}/bash-aliases/git.sh
      . ${config.xdg.configHome}/bash-aliases/vagrant.sh'';
    bashrcExtra = ". $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh";
    shellAliases = {
      grep = "grep --color=auto";
      ll = "ls -l";
      ls = "eza --color=auto --icons";
      edit = "emacs -nw";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      l = "ls -F";
      la = "ls -a";
      ll = "ls -alF";
    };        
  };
  
  home.file {
    ".gitconfig".source = "config/git/gitconfig_work";
    ".face.icon".source = "config/face/work.jpg";
  };

  xdg.configFile = {
    "doom/config.el".source = "dots/.config/doom/config.el";
    "doom/init.el".source = "dots/.config/doom/init.el";
    "doom/packages.el".source = "dots/.config/doom/packages.el";
    "fuzzel/fuzzel.ini".source = "dots/.config/fuzzel/fuzzel.ini";
    "gh/config.yml".source = "dots/.config/gh/config.yml";
    "kanshi/config".source = "dots/.config/kanshi/config";
    "kitty/kitty.conf".source = "dots/.config/kitty/kitty.conf";
    "kitty/themes/kanagawa.conf".source = "dots/.config/kitty/themes/kanagawa.conf";
    "rofi/colors.rasi".source = "dots/.config/rofi/colors.rasi";
    "rofi/config.rasi".source = "dots/.config/rofi/config.rasi";
    "sway/config".source = "dots/.config/sway/config";
    "swaylock/config".source = "dots/.config/swaylock/config";
    "swaync/config.json".source = "dots/.config/swaync/config.json";
    "swaync/style.css".source = "dots/.config/swaync/style.css";
    "tmux/tmux.conf".source = "dots/.config/tmux/tmux.conf";
    "waybar/config.jsonc".source = "dots/.config/waybar/config.jsonc";
    "waybar/modules.jsonc".source = "dots/.config/waybar/modules.jsonc";
    "waybar/style.css".source = "dots/.config/waybar/style.css";
    "waybar/themes/kanagawa.css".source = "dots/.config/waybar/themes/kanagawa.css";
    "wallpaper".source = "dots/.config/wallpaper";

    "waybar/scripts/cava.sh".source = "config/waybar-scripts/cava.sh";
    "waybar/scripts/check_updates.sh".source = "config/waybar-scripts/check_updates.sh";
    "waybar/scripts/openweathermap.sh".source = "config/waybar-scripts/openweathermap.sh";
    "waybar/scripts/update_system.sh".source = "config/waybar-scripts/update_system.sh";
    "waybar/scripts/vpn_status.sh".source = "config/waybar-scripts/vpn_status.sh";
    "sway/config.d/locker".source = "config/sway/gnome-locker";

    "bash-aliases/bundler.sh".source = "config/bash-aliases/bundler.sh";
    "bash-aliases/copypasta.sh".source = "config/bash-aliases/copypasta.sh";
    "bash-aliases/git.sh".source = "config/bash-aliases/git.sh";
    "bash-aliases/vagrant.sh".source = "config/bash-aliases/vagrant.sh";
  }
}
