(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (guix profiles)
             (guix channels)
             (gnu home services)
             (gnu home services sound)
             (gnu home services dotfiles)
             (gnu home services guix)
             (gnu home services ssh)
             (gnu home services shells)
             (gnu home services desktop))

;; set the role so we can apply some conditional
;; configs
(define role (getenv "GUIX_ROLE"))

(home-environment
 (packages
  (specifications->packages
   (list
    "glibc-locales"
     ;; shell things ;;
    "kitty"
    "tmux"
    "tmux-themepack"
    "starship"
    ;; language things ;;
    "go"
    "protobuf"
    ;; shell utilities ;;
    "awscli@2"
    "bottom"
    "btop"
    ;; "caddy"
    "catimg"
    "direnv"
    "dos2unix"
    "du-dust"
    "eza"
    "ffmpeg"
    "glances"
    "htop"
    "imagemagick"
    "jless"
    "jq"
    "kismet"
    "lm-sensors"
    ;; mise
    "netcat"
    "nethogs"
    "net-tools"
    "nmap"
    "7zip"
    "procs"
    "progress"
    ;; "sshutle"
    "unzip"
    "zoxide"
    ;; development related things ;;
    "bat"
    "bats"
    "coreutils"
    "git-delta"
    "emacs"
    "fd"
    "git"
    "gopls"
    "graphviz"
    "imhex"
    "jujutsu"
    "ripgrep"
    "shellcheck"
    "tig"
    ;; shell usability things ;;
    "croc" ; file sharing
    "neofetch" ; system info
    "qrencode" ; qrcode generator
    "whois" ; dns info lookups
    "playerctl" ; control audio via dbus
    "brightnessctl" ; control backlight stuff

    ;; extra stuff ;;
    "hunspell"
    "hunspell-dict-en"
    "hunspell-dict-en-us"
    ;; "1password-gui"
    ;; "1password-cli"
    "weechat"
    "weechat-wee-slack"
    ;; desktop stuff ;;
    "keepassxc"
    "krita"
    "librewolf"
    "ungoogled-chromium"
    ;; desktop environment stuff
    "swayfx"
    "swayidle"
    "swaylock"
    "waylock"
    "swaybg"
    "waybar"
    "clipman"
    "wl-clipboard"
    "rofi"
    "fuzzel"
    "grim"
    "wlsunset"                  ;; Night light
    "bemenu"
    "slurp"                     ;; screen area selection
    "dunst"                     ;; notifications
    "pinentry"                  ;; prompt for pgp, ssh, ...
    "pavucontrol"               ;; audio control
    "pamixer"                   ;; keyboard audio volumne
    "brightnessctl"             ;; keyboard display brightness
    "qtwayland"
    "swappy"            ;; snapshot and edit
    "wf-recorder"             ;; Screen Recording
    "bemoji"
    "kanshi"   ;; hot pluggable screen config
    "udiskie" ;; removable disk automounter
    "lxqt-policykit" ;; polkit
    "xsettingsd" ;; settings for x windows
    "swaynotificationcenter" ;; toasts
    "blueman" ;; bluetooth manager



    "date"
    "font-openmoji"
    "font-google-noto"
    "font-google-noto-emoji"
    "font-ibm-plex"
    "font-hack"
    "font-jetbrains-mono"
    "font-awesome"
    "font-google-material-design-icons"
    "font-fira-code"
    )))

 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (append (list (service home-bash-service-type
                         (home-bash-configuration
                          (bashrc (list (local-file "config/bashrc")
                                        (local-file "config/bash-aliases/default.sh")
                                        (local-file "config/bash-aliases/bundler.sh")
                                        (local-file "config/bash-aliases/copypasta.sh")
                                        (local-file "config/bash-aliases/git.sh")
                                        (local-file "config/bash-aliases/vagrant.sh")))))
                ;; Direct copy configuration files (these are readonly with perms stripped)
                (service home-dotfiles-service-type
                         (home-dotfiles-configuration
                          (directories '("./dots"))))
                ;; (simple-service 'my-override
                ;;                 home-shell-profile-service-type
                ;;                 (list (local-file "config/profile-stub")))
                (service home-files-service-type
                         `((".gitconfig" ,(local-file(cond ((equal? role "work") "config/git/gitconfig_work")
                                  (else "config/git/gitconfig"))))
                           (".config/guix/zzz-guix.sh" ,(local-file "config/guix/zzz-guix.sh"))
                           (".config/waybar/scripts/cava.sh" ,(local-file "config/waybar-scripts/cava.sh" #:recursive? #t))
                           (".config/waybar/scripts/check_updates.sh" ,(local-file "config/waybar-scripts/check_updates.sh" #:recursive? #t))
                           (".config/waybar/scripts/openweathermap.sh" ,(local-file "config/waybar-scripts/openweathermap.sh" #:recursive? #t))
                           (".config/waybar/scripts/update_system.sh" ,(local-file "config/waybar-scripts/update_system.sh" #:recursive? #t))
                           (".config/waybar/scripts/vpn_status.sh" ,(local-file "config/waybar-scripts/vpn_status.sh" #:recursive? #t))
                           (".config/sway/config.d/customs" ,(local-file(cond ((equal? role "work") "config/sway/work")
                                                           (else "config/sway/personal"))))
                           (".local/bin/start-sway" ,(local-file "config/bins/start-sway" #:recursive? #t))
                           (".envrc" ,(local-file(cond ((equal? role "work") "config/home-envrc/envrc-work")
                                                           (else "config/home-envrc/envrc-personal"))))
                           (".face" ,(local-file(cond ((equal? role "work") "config/face/work.jpg")
                                  (else "config/face/personal.jpg"))))
                           (".face.icon" ,(local-file(cond ((equal? role "work") "config/face/work.jpg")
                                  (else "config/face/personal.jpg"))))))
                (service home-dbus-service-type)
                (service home-pipewire-service-type
                         (home-pipewire-configuration
                          (enable-pulseaudio? #t)))
                (service home-ssh-agent-service-type)
                (service home-openssh-service-type
                         (home-openssh-configuration
                          (add-keys-to-agent "yes"))))
                %base-home-services)))
