{
  config,
  lib,
  pkgs,
  ...
}:

let
  nixGL = import ./nixGL.nix { inherit pkgs lib; };
in
{
  home.packages = with pkgs; [
    # Libraries
    libffi
    zlib

    # Lets define our shell related things
    kitty
    tmux
    starship

    # Language related things
    crystal
    go
    jdk
    protobuf
    powershell
    python3
    ruby_3_4
    shards
    nodePackages.typescript-language-server

    # Shell utilities
    act
    aircrack-ng
    awscli2
    bandwhich
    bottom
    broot
    btop
    caddy
    catimg
    direnv
    dos2unix
    dust
    eza
    ffmpeg
    glances
    gnupg
    gnutar
    gomplate
    gotop
    gzip
    heroku
    hfsprogs
    htop
    imagemagick
    jless
    jq
    kismet
    dysk
    lm_sensors
    metal-cli
    miniserve
    mise
    netcat
    nethogs
    nettools
    nix-direnv
    nmap
    p7zip
    postgresql
    procs
    progress
    sshuttle
    unixtools.netstat
    unzip
    xar
    xz
    yq-go
    zip
    zoxide

    # Development things
    bat # cat alternative
    bats
    clang
    cmake
    coreutils
    delta
    emacs
    fd
    (hiPrio gcc)
    gh
    gnupg
    git
    git-crypt
    git-extras
    gitui
    gnugrep
    gopls
    graphviz
    helix
    iconv
    icr
    imhex
    jjui
    jujutsu
    lazygit
    libarchive
    libffi
    msitools
    mono
    nixfmt
    nodePackages.mermaid-cli
    openssl
    osslsigncode
    redis
    ripgrep
    shellcheck
    sqlite
    ssh-audit
    tig
    tree-sitter

    # Shell usability things
    croc # CLI file transfer
    neofetch
    qrencode # Create QR
    whois
    wtfutil
    _1password-gui
    _1password-cli

    # weechat things
    aspell
    aspellDicts.en
    (weechat.override {
      configure =
        { availablePlugins, ... }:
        {
          plugins = with availablePlugins; [ (python.withPackages (ps: with ps; [ websocket-client ])) ];
        };
    })
    weechatScripts.wee-slack

    # Desktop tools
    brightnessctl # Control brightness
    keepassxc # Local password manager
    (nixGL librewolf) # Stripped down firefox
    (nixGL ungoogled-chromium) # Stripped down chromium
    (nixGL swayfx) # Sway with FX
    swayidle # Idler
    swaylock # locker
    waylock # locker
    swaybg
    waybar
    clipman
    wl-clipboard
    rofi
    fuzzel
    grim
    wlsunset
    bemenu
    slurp
    dunst
    pinentry-gnome3
    pavucontrol
    pamixer
    swappy
    wf-recorder
    bemoji
    kanshi
    udiskie
    lxqt.lxqt-policykit
    xsettingsd
    swaynotificationcenter
    blueman
    networkmanagerapplet

    xdg-desktop-portal
    xdg-desktop-portal-wlr

    hunspell # dictionary for vnote
    hunspellDicts.en-us-large
    otpclient # 2FA password generator
    (nixGL nyxt) # Browser

    fontconfig
    noto-fonts
    nerd-fonts.noto
    catppuccin-cursors.mochaLavender
    papirus-icon-theme

    (nixGL thunderbird)
  ];

  programs.bash = {
    enable = true;
    initExtra = ". ${config.xdg.configHome}/bashalicious/bashrc";
    bashrcExtra = "";
  };

  programs.chromium = {
    enable = true;
    package = (nixGL pkgs.ungoogled-chromium);
    extensions = [
      { id = "ncigbofjfbodhkaffojakplpmnleeoee"; } # Animation Policy
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
    ];
  };

  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
  };

  systemd.user.services = {
    sshagent = {
      Unit = {
        Description = "SSH Agent";
        Requires = "graphical-session.target";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        Environment = "SSH_AUTH_SOCK=%t/ssh-agent.sock";
        ExecStart = "ssh-agent -D -a $SSH_AUTH_SOCK";
        Restart = "always";
      };
    };
    nm-applet = {
      Unit = {
        Description = "Network Manager Applet";
        Requires = "graphical-session.target";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "nm-applet";
        Restart = "always";
      };
    };
    blueman-applet = {
      Unit = {
        Description = "Bluetooth Applet";
        Requires = "graphical-session.target";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "blueman-applet";
        Restart = "always";
      };
    };
    # conky = {
    #   Unit = {
    #     Description = "Conky bar";
    #     Requires = "graphical-session.target";
    #   };
    #   Service = {
    #     ExecStart =
    #       "${pkgs.conky}/bin/conky --pause=10 -c ${config.xdg.configHome}/conky/conkyrc";
    #     Restart = "always";
    #   };
    # };
    # wallpaper = {
    #   Unit = {
    #     Description = "Wallpaper changer at sunrise/sunset";
    #     Requires = "graphical-session.target";
    #   };
    #   Service = {
    #     ExecStart =
    #       "${config.xdg.configHome}/scripts/wallpaper_changer_dynamic.sh poll";
    #     Restart = "always";
    #   };
    # };
  };

  # Point the aspell config to the correct location
  home.file.".aspell.conf".text = "data-dir ${config.home.homeDirectory}/.nix-profile/lib/aspell";

  home.file.".config".source = ../dots/.config;
  home.file.".config".recursive = true;
  home.file.".local".source = ../dots/.local;
  home.file.".local".recursive = true;
  home.file.".gitignore_global".source = ../dots/.gitignore_global;
}
