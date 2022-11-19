#!/usr/bin/env bash

# Always ensure apt knows there is no one to talk to
export DEBIAN_FRONTEND=noninteractive

# Core desktop packages
sentinel_file="/opt/system-config"
nix_user="${NIX_USER:-${SUDO_USER:-${USER}}}"

echo -e "🚧 Running System Configuration 🚧\n\n"

if [ ! -f "${sentinel_file}" ]; then
    # First we start with uninstalling all the known
    # extras we don't want installed
    echo -n "⛔ Removing whoopsie... "

    if apt-get purge -qqy whoopsie > /dev/null 2>&1; then
        echo "✔"
    else
        echo "❌"
        exit 1
    fi

    echo -n "⛔ Removing snap... "

    if apt-get purge -qqy snapd > /dev/null 2>&1; then
        echo "✔"
    else
        echo "❌"
        exit 1
    fi

    echo -n "⛔ Removing any snap artifacts... "

    if rm -rf /var/cache/snapd > /dev/null 2>&1; then
        echo "✔"
    else
        echo "❌"
        exit 1
    fi

    echo -n "⛔ Disabling snap from reinstall... "

    echo -e "Package: snapd\nPin: release *\nPin-Priority: -1\n" > /etc/apt/preferences.d/no-snap
    echo "✔"

    echo -n "⛔ Removing any leftover packages... "

    if apt-get autopurge -yqq > /dev/null 2>&1; then
        echo "✔"
    else
        echo "❌"
        exit 1
    fi

    echo -n "🛑 Disabling service auto starts... "

    cat <<-EOF > /usr/sbin/policy-rc.d
#!/usr/bin/env bash
exit 101
EOF

    chmod 0755 /usr/sbin/policy-rc.d

    echo "✔"

    echo -n "☕ Installing NIX... "
    if ! sh <(curl -L https://nixos.org/nix/install) --daemon; then
        echo "❌ NIX install failed"
        exit 1
    fi

    echo -n "📋 Installing git... "
    if apt-get install -yqq git 2>&1; then
        echo "✔"
    else
        echo "❌"
        exit 1
    fi

    echo -n "🧹 Remove any leftover packages... "
    if apt-get -yqq autoremove 2>&1; then
        echo "✔"
    else
        echo "❌"
        exit 1
    fi

    echo -n "🧹 Cleanup any package artifacts... "
    if apt-get -yqq autoclean 2>&1; then
        echo "✔"
    else
        echo "❌"
        exit 1
    fi

    touch "${sentinel_file}"
fi

echo -e "\n🗿 Core system configuration complete! 🗿"
echo "  *** PLEASE REBOOT ***"
