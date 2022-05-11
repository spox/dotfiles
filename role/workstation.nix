{ config, lib, pkgs, ... }:

let
  doom-emacs = pkgs.callPackage(builtins.fetchTarball {
    url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
  }) {
    doomPrivateDir = ~/.config/doom;
  };

  nixgl = import <nixgl> {};
in {
  home.packages = with pkgs; [
    nixgl.auto.nixGLDefault

    # Lets define our shell related things
    kitty
    tmux
    tmuxPlugins.nord
    starship

    # Language related things
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
    emacs-nox
    fd
    gh
    gnupg
    git
    git-crypt
    gitui
    helix
    lazygit
    ripgrep
    ssh-audit

    # Shell usability things
    croc # CLI file transfer
    neofetch
    qrencode # Create QR
    whois

    # weechat things
    aspell
    weechat

    # Desktop tools
    arandr # Define monitor layout
    autorandr # Automatically update monitor layouts
    conky # System resources monitor
    dunst # Notification daemon
    feh # Background image
    i3-gaps # Window manaer
    i3-auto-layout # Automatic optimal tiling
    i3status-rust # Status bar for i3
    picom # Composter
    rofi # Launcher (dmenu replacement)
    rofi-calc
    rofi-emoji
    sunwait # Time of day calculation
    unclutter # Mouse hider
    wmctrl
    xclip # copy / paste
    xss-lock # X screenlock

    # Applications
    chromium
    firefox
    zoom-us
  ];

  programs.bash = {
    enable = true;
    historyControl = [
      "ignoredups"
      "ignorespace"
    ];
    sessionVariables = {
      BROWSER  = "firefox";
      EDITOR   = "emacsclient -t";
      GIT_EDITOR = "emacsclient -t";
      IRC_CLIENT = "weechat";
      TERMINAL = "kitty";
      KDEWM = "${pkgs.i3-gaps}/bin/i3";
      PATH = "\$HOME/.nix-profile/bin:\$PATH:\$HOME/bin:\$HOME/.local/bin";
    };
    initExtra = ". \"\${HOME}\"/.config/bash-aliases/bundler.sh
      . \"\${HOME}\"/.config/bash-aliases/copypasta.sh
      . \"\${HOME}\"/.config/bash-aliases/editor.sh
      . \"\${HOME}\"/.config/bash-aliases/git.sh
      . \"\${HOME}\"/.config/bash-aliases/vagrant.sh";
    bashrcExtra = ". \$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh";
    shellAliases = {
      egrep = "egrep --color=auto";
      em = "emacsclient -t";
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
        min_time = 5000;  # Show command duration over 5 seconds
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
        format = "[\($state( $progress_current of $progress_total)\)]($style) ";
      };
      git_status = {
        conflicted = "⚔️ ";
        ahead = "🏎️ 💨 ×$\{count}";
        behind = "🐢 ×\${count}";
        diverged = "🔱 🏎️ 💨 ×$\{ahead_count} 🐢 ×\${behind_count}";
        untracked = "🛤️  ×$\{count}";
        stashed = "📦 ";
        modified = "📝 ×\${count}";
        staged = "🗃️  ×$\{count}";
        renamed = "📛 ×\${count}";
        deleted = "🗑️  ×$\{count}";
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
      package = {
        disabled = true;
      };
      ruby = {
        disabled = false;
      };
      golang = {
        disabled = false;
      };
      time = {
        time_format = "%T";
        format = "🕙 $time($style) ";
        style = "bright-white";
        disabled = true;
      };
      jobs = {
        symbol = "👷";
      };
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
    plugins = [ pkgs.tmuxPlugins.nord ];
    extraConfig = "
set-window-option -g allow-rename off
set-window-option -g automatic-rename off
set-option -g display-time 7000
";
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  services.emacs = {
    enable = true;
    package = doom-emacs;
  };

  home.sessionVariables = {
    BROWSER  = "firefox";
    EDITOR   = "emacsclient -t";
    GIT_EDITOR = "emacsclient -t";
    IRC_CLIENT = "weechat";
    TERMINAL = "kitty";
    KDEWM = "${pkgs.i3-gaps}/bin/i3";
    PATH = "\$HOME/.nix-profile/bin:\$PATH:\$HOME/bin:\$HOME/.local/bin";
  };

  home.file.".face".source = ../config/fry.png;
  home.file.".local/bin/default-terminal".source = ../config/bin/default-terminal;

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
    "doom/config.el".source = ../config/doom/config.el;
    "doom/init.el".source = ../config/doom/init.el;
    "doom/packages.el".source = ../config/doom/packages.el;
    "i3/colors.ayu".source = ../config/i3/colors.ayu;
    "i3/config".source = ../config/i3/config;
    "kitty/kitty.conf".source = ../config/kitty/kitty.conf;
    "picom/picom.conf".source = ../config/picom.conf;
    "rofi/config.rasi".source = ../config/rofi/config.rasi;
    "rofi/ayu-mirage.rasi".source = ../config/rofi/ayu-mirage.rasi;
    "scripts/i3_ws_to_primary.sh".source = ../config/scripts/i3_ws_to_primary.sh;
    "scripts/rofi_power_menu.sh".source = ../config/scripts/rofi_power_menu.sh;
    "scripts/rofi_suspend.sh".source = ../config/scripts/rofi_suspend.sh;
    "scripts/wallpaper_changer_dynamic.sh".source = ../config/scripts/wallpaper_changer_dynamic.sh;
    "scripts/wallpaper_changer_normal.sh".source = ../config/scripts/wallpaper_changer_normal.sh;
    "wallpapers/default/material.jpg".source = ../config/wallpapers/default/material.jpg;
    "wallpapers/default/octocat.jpg".source = ../config/wallpapers/default/octocat.jpg;
    "wallpapers/default/simple.png".source = ../config/wallpapers/default/simple.png;
    "wallpapers/default/space.jpg".source = ../config/wallpapers/default/space.jpg;
    "wallpapers/default/spaceshuttle.png".source = ../config/wallpapers/default/spaceshuttle.png;
    "wallpapers/default/morning.jpg".source = ../config/wallpapers/default/octocat.jpg;
    "wallpapers/default/midday.jpg".source = ../config/wallpapers/default/space.jpg;
    "wallpapers/default/dusk.jpg".source = ../config/wallpapers/default/space.jpg;
    "wallpapers/default/night.jpg".source = ../config/wallpapers/default/material.jpg;
  };
}
