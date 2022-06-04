#!/usr/bin/env bash
sentinel_file="/opt/system-config"

# This won't be set during install so manually define it
export NIX_PATH="${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels"

echo -e "🦥 Running user configuration...\n"

# First check if the nix directory exists
if [ ! -f "${sentinel_file}" ]; then
    echo "🚨 Please run the './bin/system.sh' script"
    exit 1
fi

echo -n "📺 Add package channel... "

if nix-channel --add https://nixos.org/channels/nixpkgs-unstable && nix-channel --update > /dev/null 2>&1; then
    echo "✔"
else
    echo "❌"
    exit 1
fi

echo -n "📺 Add nixgl channel... "

if nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update > /dev/null 2>&1; then
    echo "✔"
else
    echo "❌"
    exit 1
fi

echo -n "🏠 Add home-manager channel... "

if nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager && nix-channel --update > /dev/null 2>&1; then
    echo "✔"
else
    echo "❌"
    exit 1
fi

echo -n "📥 Cloning in dotfiles... "
rm -rf ~/.config/nixpkgs
if git clone https://github.com/spox/dotfiles ~/.config/nixpkgs > /dev/null 2>&1; then
    echo "✔"
else
    echo "❌"
    exit 1
fi

# Need to stub in this directory for initial check to succeed
mkdir -p ~/.config/doom
# The .face file will already exist, so delete it
rm -f ~/.face

# Remove profile and bashrc since home manager will generate them
echo -n "🛠 Removing shell configuration files... "
rm -f "${HOME}/.bashrc" "${HOME}/.profile"
echo "✔"

# Update the home.nix file with machine name
echo -n "🛠 Configuring for ${HOSTNAME}... "
set -i "s/%MACHINE_NAME%/${HOSTNAME}/" "${HOME}/.config/nixpkgs/home.nix"
echo "✔"

echo -n "🏗 Install home-manager... "

if nix-shell '<home-manager>' -A install > /dev/null 2>&1; then
    echo "✔"
else
    echo "❌"
    exit 1
fi

echo -n "🛠 Configuring self for nix... "
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
echo "✔"

echo "   *** PLEASE REBOOT ***"
