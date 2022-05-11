#!/usr/bin/env bash
sentinel_file="/opt/system-config"

echo -e "🦥 Running user configuration...\n"

# First check if the nix directory exists
if [ ! -f "${sentinel_file}" ]; then
    echo "🚨 Please run the './bin/system.sh' script"
    exit 1
fi

echo -n "📥 Cloning in dotfiles... "
if git clone https://github.com/spox/dotfiles ~/.config/nixpkgs > /dev/null 2>&1; then
    echo "✔"
else
    echo "❌"
    exit 1
fi

echo -n "📺 Add package channel... "

if nix-channel --add https://nixos.org/channels/nixpkgs-unstable && nix-channel --update > /dev/null 2>&1; then
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

echo -n "🏗 Install home-manager... "

if nix-shell '<home-manager>' -A install > /dev/null 2>&1; then
    echo "✔"
else
    echo "❌"
    exit 1
fi

echo -n "🛠 Configuring self for nix... "
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
export PATH="~/.nix-profile/bin:${PATH}"
echo "✔"

# Remove profile and bashrc since home manager will generate them
echo -n "🛠 Removing shell configuration files... "
rm -f "${HOME}/.bashrc" "${HOME}/.profile"
echo "✔"

echo "🏗 Building and enabling home... "
home-manager switch
