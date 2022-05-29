{ config, lib, pkgs, ... }:

let nixgl = import <nixgl> { };
in {
  home.packages = with pkgs; [
    nixgl.auto.nixGLDefault

    # Lets define our shell related things
    kitty
    tmux
    tmuxPlugins.nord
    starship

    # Language related things
    crystal
    go
    python
    ruby

    # Shell utilities
    catimg
    direnv
    gnupg
    gnutar
    gzip
    htop
    imagemagick
    jq
    keepassxc
    lm_sensors
    netcat
    nmap
    p7zip
    unzip
    xz
    yq
    zip

    # Development things
    bat
    coreutils
    delta
    emacs28NativeComp
    fd
    gh
    gnupg
    git
    git-crypt
    gitui
    gopls
    graphviz
    helix
    icr
    lazygit
    nixfmt
    ripgrep
    shellcheck
    ssh-audit
    terraform
    tig

    # Shell usability things
    croc # CLI file transfer
    neofetch
    qrencode # Create QR
    whois

    # weechat things
    aspell
    weechat
    weechatScripts.wee-slack

    # Desktop tools
    arandr # Define monitor layout
    autorandr # Automatically update monitor layouts
    conky # System resources monitor
    dunst # Notification daemon
    feh # Background image
    i3-gaps # Window manaer
    i3-auto-layout # Automatic optimal tiling
    i3status-rust # Status bar for i3
    otpclient # 2FA password generator
    picom # Composter
    redshift # Color temperature adjustor
    rofi # Launcher (dmenu replacement)
    rofi-calc
    rofi-emoji
    sunwait # Time of day calculation
    wmctrl
    xclip # copy / paste
    xss-lock # X screenlock

    # Applications
    chromium
    firefox
  ];

  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "emacs -nw";
      GIT_EDITOR = "emacs -nw";
      IRC_CLIENT = "weechat";
      KDEWM = "${pkgs.i3-gaps}/bin/i3";
      PATH =
        "$HOME/.nix-profile/bin:$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.local/bin.go:$HOME/.emacs.d/bin";
    };
    initExtra = ''
      . "''${HOME}"/.config/bash-aliases/bundler.sh
            . "''${HOME}"/.config/bash-aliases/copypasta.sh
            . "''${HOME}"/.config/bash-aliases/editor.sh
            . "''${HOME}"/.config/bash-aliases/git.sh
            . "''${HOME}"/.config/bash-aliases/vagrant.sh'';
    bashrcExtra = ". $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh";
    shellAliases = {
      egrep = "egrep --color=auto";
      em = "emacs -nw";
      fgrep = "fgrep --color=auto";
      grep = "grep --color=auto";
      kitty = "nixGL kitty";
      l = "ls -CF";
      la = "ls -A";
      ll = "ls -alF";
      ls = "ls --color=auto";
    };
  };

  programs.chromium = {
    enable = true;
    extensions = [
      { id = "ncigbofjfbodhkaffojakplpmnleeoee"; } # Animation Policy
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
    ];
  };

  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.go = {
    enable = true;
    goBin = ".local/bin.go";
    goPath = ".local/go";
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      auto-completion = true;
      auto-info = true;
      completion-trigger-len = 2;
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      line-number = "relative";
      lsp.display-messages = true;
      search = {
        smart-case = true;
        wrap-around = true;
      };
      true-color = true;
    };
  };

  programs.keychain = {
    enable = true;
    enableBashIntegration = true;
    enableXsessionIntegration = true;
  };

  # programs.kitty = {
  #   enable   = true;
  #   settings = { #lib.attrsets.recursiveUpdate (import ../program/terminal/alacritty/default-settings.nix) {
  #     shell.program = "/usr/bin/bash";
  #   };
  # };

  programs.starship = {
    enable = true;
    settings = {
      battery = {
        full_symbol = "🔋";
        charging_symbol = "🔌";
        discharging_symbol = "⚡";
        # display = {
        #   threshold = 30;
        #   style = "bold red";
        # };
      };
      character = {
        success_symbol = "➜";
        error_symbol = "✗(red)";
      };
      cmd_duration = {
        min_time = 5000; # Show command duration over 5 seconds
        format = " took [$duration]($style)";
      };
      directory = {
        truncation_length = 5;
        format = "[$path]($style)[$lock_symbol]($lock_style) ";
      };
      git_branch = {
        format = " [$symbol$branch]($style) ";
        symbol = "🍣 ";
        style = "bold yellow";
      };
      git_commit = {
        commit_hash_length = 8;
        style = "bold white";
      };
      git_state = {
        format = "[($state( $progress_current of $progress_total))]($style) ";
      };
      git_status = {
        conflicted = "⚔️ ";
        ahead = "🏎️ 💨 ×\${count}";
        behind = "🐢 ×\${count}";
        diverged = "🔱 🏎️ 💨 ×\${ahead_count} 🐢 ×\${behind_count}";
        untracked = "🛤️  ×\${count}";
        stashed = "📦 ";
        modified = "📝 ×\${count}";
        staged = "🗃️  ×\${count}";
        renamed = "📛 ×\${count}";
        deleted = "🗑️  ×\${count}";
        style = "bright-white";
        format = "$all_status$ahead_behind";
      };
      hostname = {
        ssh_only = false;
        disabled = false;
      };
      memory_usage = {
        format = "$symbol[\${ram}( | \${swap})]($style) ";
        threshold = 70;
        style = "bold dimmed white";
        disabled = false;
      };
      package = { disabled = true; };
      ruby = { disabled = false; };
      golang = { disabled = false; };
      time = {
        time_format = "%T";
        format = "🕙 $time($style) ";
        style = "bright-white";
        disabled = true;
      };
      jobs = { symbol = "👷"; };
      custom = {
        sudo = {
          when = "sudo -n --validate";
          style = "#ffb05b";
          format = "[ ELEVATED ]($style)";
        };
      };
    };
  };

  programs.tmux = {
    enable = true;
    shortcut = "j";
    newSession = true;
    aggressiveResize = true;
    plugins = [ pkgs.tmuxPlugins.gruvbox ];
    extraConfig = ''

      set-window-option -g allow-rename off
      set-window-option -g automatic-rename off
      set-option -g display-time 7000
    '';
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  # Connecting with a client mucks up themes
  # so just use isolated instance
  # services.emacs = { enable = true; };

  services.redshift = {
    enable = true;
    latitude = 45.1722;
    longitude = -122.201;
    temperature.night = 2000;
    tray = true;
  };

  services.unclutter = { enable = true; };

  systemd.user.services.wallpaper = {
    Unit = {
      Description = "Wallpaper changer at sunrise/sunset";
      Requires = "graphical-session.target";
    };
    Service = {
      ExecStart =
        "/home/spox/.config/scripts/wallpaper_changer_dynamic.sh poll";
      Restart = "always";
    };
  };

  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "emacs -nw";
    GIT_EDITOR = "emacs -nw";
    IRC_CLIENT = "weechat";
    KDEWM = "${pkgs.i3-gaps}/bin/i3";
  };

  home.file.".local/bin/default-terminal".source =
    ../config/bin/default-terminal;
  home.file.".gitignore_global".source = ../config/git/gitignore_global;
  home.file.".doom.d/config.el".source = ../config/doom/config.el;
  home.file.".doom.d/init.el".source = ../config/doom/init.el;
  home.file.".doom.d/packages.el".source = ../config/doom/packages.el;

  xsession.enable = true;
  xsession.windowManager.command = "/usr/bin/startplasma-x11";
  xsession.profileExtra = "export KDEWM=${pkgs.i3-gaps}/bin/i3";

  xdg.configFile = {
    "bash-aliases/bundler.sh".source = ../config/bash/aliases/bundler.sh;
    "bash-aliases/copypasta.sh".source = ../config/bash/aliases/copypasta.sh;
    "bash-aliases/editor.sh".source = ../config/bash/aliases/editor.sh;
    "bash-aliases/git.sh".source = ../config/bash/aliases/git.sh;
    "bash-aliases/vagrant.sh".source = ../config/bash/aliases/vagrant.sh;
    "conky/conkyrc".source = ../config/conky/conkyrc;
    "conky/draw_bg.lua".source = ../config/conky/draw_bg.lua;
    "gh/config.yml".source = ../config/gh/config.yml;
    "i3/colors.ayu".source = ../config/i3/colors.ayu;
    "i3/config".source = ../config/i3/config;
    "kitty/kitty.conf".source = ../config/kitty/kitty.conf;
    "picom/picom.conf".source = ../config/picom.conf;
    "rofi/config.rasi".source = ../config/rofi/config.rasi;
    "rofi/ayu-mirage.rasi".source = ../config/rofi/ayu-mirage.rasi;
    "scripts/i3_ws_to_primary.sh".source =
      ../config/scripts/i3_ws_to_primary.sh;
    "scripts/rofi_power_menu.sh".source = ../config/scripts/rofi_power_menu.sh;
    "scripts/rofi_suspend.sh".source = ../config/scripts/rofi_suspend.sh;
    "scripts/wallpaper_changer_dynamic.sh".source =
      ../config/scripts/wallpaper_changer_dynamic.sh;
    "wallpapers/day/01.jpg".source = ../config/wallpapers/day/01.jpg;
    "wallpapers/day/02.jpg".source = ../config/wallpapers/day/02.jpg;
    "wallpapers/day/03.jpg".source = ../config/wallpapers/day/03.jpg;
    "wallpapers/day/04.jpg".source = ../config/wallpapers/day/04.jpg;
    "wallpapers/day/05.jpg".source = ../config/wallpapers/day/05.jpg;
    "wallpapers/day/06.jpg".source = ../config/wallpapers/day/06.jpg;
    "wallpapers/day/07.jpg".source = ../config/wallpapers/day/07.jpg;
    "wallpapers/day/08.jpg".source = ../config/wallpapers/day/08.jpg;
    "wallpapers/day/09.jpg".source = ../config/wallpapers/day/09.jpg;
    "wallpapers/day/10.jpg".source = ../config/wallpapers/day/10.jpg;
    "wallpapers/day/11.jpg".source = ../config/wallpapers/day/11.jpg;
    "wallpapers/day/12.jpg".source = ../config/wallpapers/day/12.jpg;
    "wallpapers/day/13.jpg".source = ../config/wallpapers/day/13.jpg;
    "wallpapers/day/14.jpg".source = ../config/wallpapers/day/14.jpg;
    "wallpapers/day/15.jpg".source = ../config/wallpapers/day/15.jpg;
    "wallpapers/day/16.webp".source = ../config/wallpapers/day/16.webp;
    "wallpapers/day/17.jpg".source = ../config/wallpapers/day/17.jpg;
    "wallpapers/day/18.jpg".source = ../config/wallpapers/day/18.jpg;
    "wallpapers/day/19.jpg".source = ../config/wallpapers/day/19.jpg;
    "wallpapers/day/20.jpg".source = ../config/wallpapers/day/20.jpg;
    "wallpapers/day/21.jpg".source = ../config/wallpapers/day/21.jpg;
    "wallpapers/day/22.jpg".source = ../config/wallpapers/day/22.jpg;
    "wallpapers/night/01.jpg".source = ../config/wallpapers/night/01.jpg;
    "wallpapers/night/02.jpg".source = ../config/wallpapers/night/02.jpg;
    "wallpapers/night/03.jpg".source = ../config/wallpapers/night/03.jpg;
    "wallpapers/night/04.jpg".source = ../config/wallpapers/night/04.jpg;
    "wallpapers/night/05.jpg".source = ../config/wallpapers/night/05.jpg;
    "wallpapers/night/06.jpg".source = ../config/wallpapers/night/06.jpg;
    "wallpapers/night/07.jpg".source = ../config/wallpapers/night/07.jpg;
    "wallpapers/night/08.jpg".source = ../config/wallpapers/night/08.jpg;
    "wallpapers/night/09.jpg".source = ../config/wallpapers/night/09.jpg;
    "wallpapers/night/10.jpg".source = ../config/wallpapers/night/10.jpg;
    "wallpapers/night/11.jpg".source = ../config/wallpapers/night/11.jpg;
    "wallpapers/night/12.png".source = ../config/wallpapers/night/12.png;
    "wallpapers/night/13.png".source = ../config/wallpapers/night/13.png;
    "wallpapers/night/14.jpg".source = ../config/wallpapers/night/14.jpg;
    "wallpapers/night/15.jpg".source = ../config/wallpapers/night/15.jpg;
    "wallpapers/night/16.jpg".source = ../config/wallpapers/night/16.jpg;
    "wallpapers/night/17.jpg".source = ../config/wallpapers/night/17.jpg;
  };
}
