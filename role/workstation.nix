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
    python3
    python3Packages.pip
    python3Packages.websocket-client
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
    aspellDicts.en
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
      . ${config.xdg.configHome}/bash-aliases/bundler.sh
            . ${config.xdg.configHome}/bash-aliases/copypasta.sh
            . ${config.xdg.configHome}/bash-aliases/git.sh
            . ${config.xdg.configHome}/bash-aliases/vagrant.sh'';
    bashrcExtra = ". $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh";
    shellAliases = {
      edit = "emacs -nw";
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

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Noto Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      force_ltr = false;
      adjust_line_height = 0;
      adjust_column_width = 0;
      adjust_baseline = 0;
      disable_ligatures = "never";
      cursor_shape = "underline";
      cursor_beam_thickness = 1;
      cursor_underline_thickness = 2;
      cursor_blink_interval = -1;
      cursor_stop_blinking_after = 15;
      scrollback_lines = 2000;
      scrollback_pager =
        "less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
      scrollback_pager_history_size = 0;
      scrollback_fill_enlarged_window = true;
      mouse_hide_wait = 3;
      url_color = "#0087bd";
      url_style = "double";
      open_url_with = "default";
      url_prefixes = "http https";
      detect_urls = true;
      copy_on_select = false;
      strip_trailing_spaces = "smart";
      select_by_word_characters = "@-./_~?&=%+#";
      click_interval = -1;
      focus_follows_mouse = false;
      pointer_shape_when_grabbed = "arrow";
      default_pointer_shape = "beam";
      pointer_shape_when_dragging = "beam";
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
      enable_audio_bell = true;
      visual_bell_duration = "0.3";
      visual_bell_color = "#BF616A";
      window_alert_on_bell = true;
      bell_on_tab = true;
      command_on_bell = "none";
      bell_path = "none";
      window_margin_width = 0;
      window_padding_width = 0;
      hide_window_decorations = true;
      window_logo_path = "none";
      resize_draw_strategy = "static";
      resize_in_steps = false;
      visual_window_select_characters = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
      confirm_os_window_close = 0;
      background_opacity = 1;
      allow_remote_control = false;
      listen_on = "none";
      update_check_interval = 0;
      startup_session = "none";
      clipboard_control =
        "write-clipboard write-primary read-clipboard-ask read-primary-ask";
      clipboard_max_size = 64;
      allow_hyperlinks = true;
      shell_integration = "enabled";
      term = "xterm-kitty";
      linux_display_server = "auto";
      clear_all_mouse_actions = true;
      clear_all_shortcuts = true;
    };
    keybindings = let mod = "ctrl+shift";
    in with pkgs; {
      "${mod}+c" = "copy_to_clipboard";
      "${mod}+v" = "paste_from_clipboard";
      "shift+up" = "scroll_line_up";
      "shift+down" = "scroll_line_down";
      "shift+page_up" = "scroll_page_up";
      "shift+page_down" = "scroll_page_down";
      "${mod}+home" = "scroll_home";
      "${mod}+end" = "scroll_end";
      "${mod}+plus" = "change_font_size all +1.0";
      "${mod}+minus" = "change_font_size all -1.0";
      "${mod}+equal" = "change_font_size all 0";
      "${mod}+r" = "clear_terminal reset active";
      "${mod}f5" = "load_config_file";
    };
    theme = "Gruvbox Dark";
    extraConfig = ''
      mouse_map left click ungrabbed mouse_handle_click selection link prompt
      mouse_map shift+left click grabbed,ungrabbed mouse_handle_click selection link prompt
      mouse_map left doublepress ungrabbed mouse_selection word
      mouse_map left triplepress ungrabbed mouse_selection line
    '';
  };

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

  systemd.user.services = {
    conky = {
      Unit = {
        Description = "Conky bar";
        Requires = "graphical-session.target";
      };
      Service = {
        ExecStart =
          "${pkgs.conky}/bin/conky --pause=10 -c ${config.xdg.configHome}/conky/conkyrc";
        Restart = "always";
      };
    };
    wallpaper = {
      Unit = {
        Description = "Wallpaper changer at sunrise/sunset";
        Requires = "graphical-session.target";
      };
      Service = {
        ExecStart =
          "${config.xdg.configHome}/scripts/wallpaper_changer_dynamic.sh poll";
        Restart = "always";
      };
    };
  };

  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "emacs -nw";
    GIT_EDITOR = "emacs -nw";
    IRC_CLIENT = "weechat";
    KDEWM = "${pkgs.i3-gaps}/bin/i3";
  };

  home.file.".aspell.conf".text =
    "data-dir ${config.home.homeDirectory}/.nix-profile/lib/aspell";
  home.file.".local/bin/default-terminal".source =
    ../config/bin/default-terminal;
  home.file.".gitignore_global".source = ../config/git/gitignore_global;
  home.file.".doom.d/config.el".source = ../config/doom/config.el;
  home.file.".doom.d/init.el".source = ../config/doom/init.el;
  home.file.".doom.d/packages.el".source = ../config/doom/packages.el;

  xsession = {
    profileExtra = "export KDEWM=${pkgs.i3-gaps}/bin/i3";
    windowManager = {
      command = "/usr/bin/startplasma-x11";
      i3 = {
        enable = true;
        extraConfig = ''
          exec --no-startup-id wmctrl -c Plasma
          exec --no-startup-id nixGL picom -cCfb --experimental-backends --config ${config.xdg.configHome}/picom/picom.conf
          no_focus [class="plasmashell" window_type="notification"]
          for_window [title="Desktop — Plasma"] kill; floating enable; border none
          for_window [title="Bureau — Plasma"] kill; floating enable; border none
          exec --no-startup-id ~/.config/scripts/wallpaper_changer_dynamic.sh
        '';
        config = {
          workspaceAutoBackAndForth = true;
          fonts = [ "Noto Mono 8.0" ];
          bars = [ ];
          modes = {
            resize = {
              h = "resize shrink width 10 px or 5 ppt";
              j = "resize grow height 10 px or 5 ppt";
              k = "resize shrink height 10 px or 5 ppt";
              l = "resize grow width 10 px or 5 ppt";
              Left = "resize shrink width 20 px";
              Down = "resize grow height 20 px";
              Up = "resize shrink height 20 px";
              Right = "resize grow width 20 px";
              "Shift+Left" = "resize shrink width 30 px";
              "Shift+Down" = "resize grow height 30 px";
              "Shift+Up" = "resize shrink height 30 px";
              "Shift+Right" = "resize grow width 30 px";

              Return = "mode default";
              Escape = "mode default";
            };
            move = {
              h = "move left 10 px or 5 ppt";
              j = "move down 10 px or 5 ppt";
              k = "move up 10 px or 5 ppt";
              l = "move right 10 px or 5 ppt";
              Left = "move left 20 px";
              Down = "move down 20 px";
              Up = "move up 20 px";
              Right = "move right 20 px";
              "Shift+Left" = "move left 30 px";
              "Shift+Down" = "move down 30 px";
              "Shift+Up" = "move up 30 px";
              "Shift+Right" = "move right 30 px";

              Return = "mode default";
              Escape = "mode default";
            };
          };
          keybindings = let mod = "Mod4";
          in with pkgs; {
            # Terminals
            "${mod}+Return" = "exec --no-startup-id default-terminal";
            "${mod}+Tab" = "exec --no-startup-id konsole";
            # Close focused window
            "${mod}+q" = "kill";
            # Changing window focus
            "${mod}+j" = "focus left";
            "${mod}+k" = "focus down";
            "${mod}+l" = "focus up";
            "${mod}+semicolon" = "focus right";
            # Changing window focus (arrows)
            "${mod}+Left" = "focus left";
            "${mod}+Down" = "focus down";
            "${mod}+Up" = "focus up";
            "${mod}+Right" = "focus right";
            # Move focused window
            "${mod}+Shift+j" = "move left";
            "${mod}+Shift+k" = "move down";
            "${mod}+Shift+l" = "move up";
            "${mod}+Shift+semicolon" = "move right";
            # Move focused window (arrows)
            "${mod}+Shift+Left" = "move left";
            "${mod}+Shift+Down" = "move down";
            "${mod}+Shift+Up" = "move up";
            "${mod}+Shift+Right" = "move right";
            # Splits (horizontal)
            "${mod}+h" = "split h";
            # Splits (vertical)
            "${mod}+v" = "split v";
            # Fullscreen focused container
            "${mod}+f" = "fullscreen";
            # Change layout
            "${mod}+s" = "layout stacking";
            "${mod}+w" = "layout tabbed";
            "${mod}+e" = "layout toggle split";
            # Toggle float
            "${mod}+Shift+space" = "floating toggle";
            # Change focus between tile / float
            "${mod}+space" = "focus mode_toggle";
            # Change focus to parent container
            "${mod}+a" = "focus parent";
            # Change focus to child
            "${mod}+Shift+a" = "focus child";
            # Switch to workspace
            "${mod}+1" = "workspace 1";
            "${mod}+2" = "workspace 2";
            "${mod}+3" = "workspace 3";
            "${mod}+4" = "workspace 4";
            "${mod}+5" = "workspace 5";
            "${mod}+6" = "workspace 6";
            "${mod}+7" = "workspace 7";
            "${mod}+8" = "workspace 8";
            "${mod}+9" = "workspace 9";
            "${mod}+0" = "workspace 10";
            # Move container to workspace
            "${mod}+Shift+1" = "move container to workspace 1";
            "${mod}+Shift+2" = "move container to workspace 2";
            "${mod}+Shift+3" = "move container to workspace 3";
            "${mod}+Shift+4" = "move container to workspace 4";
            "${mod}+Shift+5" = "move container to workspace 5";
            "${mod}+Shift+6" = "move container to workspace 6";
            "${mod}+Shift+7" = "move container to workspace 7";
            "${mod}+Shift+8" = "move container to workspace 8";
            "${mod}+Shift+9" = "move container to workspace 9";
            "${mod}+Shift+0" = "move container to workspace 10";
            # Scratchpad
            "${mod}+Shift+minus" = "move scratchpad";
            "${mod}+Shift+plus" = "scratchpad show";
            # Make container sticky
            "${mod}+Shift+s" = "sticky toggle";
            # Reload i3 config
            "${mod}+Shift+c" = "reload";
            # Restart i3
            "${mod}+Shift+r" = "restart";
            # Logout
            "${mod}+Shift+e" = ''
              exec --no-startup-id "qdbus org.kde.ksmserver /KSMServer logout 1 3 3'';
            # Resize container
            "${mod}+r" = "mode resize";
            # Move container
            "${mod}+m" = "focus floating; mode move";
            # Launch a program
            "${mod}+d" = "exec rofi -modi run -show";
            # Launch and application
            "${mod}+x" = "exec rofi -modi drun -show";
            # List windows
            "${mod}+Shift+d" = "exec rofi -modi window -show";
            # Change wallpaper
            "${mod}+Shift+b" =
              "exec --no-startup-id ~/.config/scripts/wallpaper_changer_dynamic.sh";
            # Lock screen
            "${mod}+Shift+u" =
              "exec qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock";
          };
          startup = [{
            command = "i3-auto-layout";
            always = true;
            notification = false;
          }];
          gaps = {
            inner = 4;
            outer = 0;
            smartGaps = true;
            smartBorders = "on";
          };
          window = { hideEdgeBorders = "smart"; };
          floating = {
            border = 1;
            modifier = "Mod4";
            criteria = [
              { class = "plasmashell"; }
              { class = "Kmix"; }
              { class = "Kruler"; }
              { class = "Plasma"; }
              { class = "Klipper"; }
              { class = "krunner"; }
              { class = "Plasmoidviewer"; }
              { class = "plasma-desktop"; }
              {
                class = "plasmashell";
                window_type = "notification";
              }
              { window_role = "pop-up"; }
              { window_role = "bubble"; }
              { window_role = "task_dialog"; }
              { window_role = "Preferences"; }
              { window_role = "About"; }
              { window_role = "dialog"; }
              { window_role = "menu"; }
              { instance = "__scratchpad"; }
            ];
          };
        };
      };
    };
  };

  xdg.configFile = {
    "bash-aliases/bundler.sh".source = ../config/bash/aliases/bundler.sh;
    "bash-aliases/copypasta.sh".source = ../config/bash/aliases/copypasta.sh;
    "bash-aliases/git.sh".source = ../config/bash/aliases/git.sh;
    "bash-aliases/vagrant.sh".source = ../config/bash/aliases/vagrant.sh;
    "conky/conkyrc".source = ../config/conky/conkyrc;
    "conky/draw_bg.lua".source = ../config/conky/draw_bg.lua;
    "gh/config.yml".source = ../config/gh/config.yml;
    "picom/picom.conf".source = ../config/picom.conf;
    "rofi/config.rasi".source = ../config/rofi/config.rasi;
    "rofi/ayu-mirage.rasi".source = ../config/rofi/ayu-mirage.rasi;
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
    "wallpapers/day/23.jpg".source = ../config/wallpapers/day/23.jpg;
    "wallpapers/day/24.png".source = ../config/wallpapers/day/24.png;
    "wallpapers/day/25.jpg".source = ../config/wallpapers/day/25.jpg;
    "wallpapers/day/26.jpg".source = ../config/wallpapers/day/26.jpg;
    "wallpapers/day/27.jpg".source = ../config/wallpapers/day/27.jpg;
    "wallpapers/day/28.jpg".source = ../config/wallpapers/day/28.jpg;
    "wallpapers/day/29.jpg".source = ../config/wallpapers/day/29.jpg;
    "wallpapers/day/30.jpg".source = ../config/wallpapers/day/30.jpg;
    "wallpapers/day/31.jpg".source = ../config/wallpapers/day/31.jpg;
    "wallpapers/day/32.jpg".source = ../config/wallpapers/day/32.jpg;
    "wallpapers/day/33.jpg".source = ../config/wallpapers/day/33.jpg;
    "wallpapers/day/34.jpg".source = ../config/wallpapers/day/34.jpg;
    "wallpapers/day/35.jpg".source = ../config/wallpapers/day/35.jpg;
    "wallpapers/day/36.jpg".source = ../config/wallpapers/day/36.jpg;
    "wallpapers/day/37.jpg".source = ../config/wallpapers/day/37.jpg;
    "wallpapers/day/38.jpg".source = ../config/wallpapers/day/38.jpg;
    "wallpapers/day/39.jpg".source = ../config/wallpapers/day/39.jpg;
    "wallpapers/day/40.jpg".source = ../config/wallpapers/day/40.jpg;
    "wallpapers/day/41.jpg".source = ../config/wallpapers/day/41.jpg;
    "wallpapers/day/42.jpg".source = ../config/wallpapers/day/42.jpg;
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
    "wallpapers/night/18.jpg".source = ../config/wallpapers/night/18.jpg;
    "wallpapers/night/19.jpg".source = ../config/wallpapers/night/19.jpg;
    "wallpapers/night/20.jpg".source = ../config/wallpapers/night/20.jpg;
    "wallpapers/night/21.jpg".source = ../config/wallpapers/night/21.jpg;
    "wallpapers/night/22.jpg".source = ../config/wallpapers/night/22.jpg;
    "wallpapers/night/23.jpg".source = ../config/wallpapers/night/23.jpg;
    "wallpapers/night/24.jpg".source = ../config/wallpapers/night/24.jpg;
    "wallpapers/night/25.jpg".source = ../config/wallpapers/night/25.jpg;

    "xmodmap".source = ../config/caps-xmodmap;
  };
}
