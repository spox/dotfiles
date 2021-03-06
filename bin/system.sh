#!/usr/bin/env bash

# Always ensure apt knows there is no one to talk to
export DEBIAN_FRONTEND=noninteractive

# Core desktop packages
sentinel_file="/opt/system-config"
nix_user="${NIX_USER:-${SUDO_USER:-${USER}}}"

echo -e "๐ง Running System Configuration ๐ง\n\n"

if [ ! -f "${sentinel_file}" ]; then
    # First we start with uninstalling all the known
    # extras we don't want installed
    echo -n "โ Removing whoopsie... "

    if apt-get purge -qqy whoopsie > /dev/null 2>&1; then
        echo "โ"
    else
        echo "โ"
        exit 1
    fi

    echo -n "โ Removing snap... "

    if apt-get purge -qqy snapd > /dev/null 2>&1; then
        echo "โ"
    else
        echo "โ"
        exit 1
    fi

    echo -n "โ Removing any snap artifacts... "

    if rm -rf /var/cache/snapd > /dev/null 2>&1; then
        echo "โ"
    else
        echo "โ"
        exit 1
    fi

    echo -n "โ Disabling snap from reinstall... "

    echo -e "Package: snapd\nPin: release *\nPin-Priority: -1\n" > /etc/apt/preferences.d/no-snap
    echo "โ"

    echo -n "โ Removing any leftover packages... "

    if apt-get autopurge -yqq > /dev/null 2>&1; then
        echo "โ"
    else
        echo "โ"
        exit 1
    fi

    echo -n "๐ Disabling service auto starts... "

    cat <<-EOF > /usr/sbin/policy-rc.d
#!/usr/bin/env bash
exit 101
EOF

    chmod 0755 /usr/sbin/policy-rc.d

    echo "โ"

    echo -n "โ Installing NIX... "
    if apt-get install -yqq nix-bin 2>&1; then
        echo "โ"
    else
        echo "โ"
        exit 1
    fi

    echo -n "๐ฉบ Adding user '${nix_user}' to nix-users group... "
    if usermod -a -G nix-users "${nix_user}" 2>&1; then
        echo "โ"
    else
        echo "โ"
        exit 1
    fi

    echo -n "๐ Installing git... "
    if apt-get install -yqq git 2>&1; then
        echo "โ"
    else
        echo "โ"
        exit 1
    fi

    echo -n "๐งน Remove any leftover packages... "
    if apt-get -yqq autoremove 2>&1; then
        echo "โ"
    else
        echo "โ"
        exit 1
    fi

    echo -n "๐งน Cleanup any package artifacts... "
    if apt-get -yqq autoclean 2>&1; then
        echo "โ"
    else
        echo "โ"
        exit 1
    fi

    touch "${sentinel_file}"
fi

echo -e "\n๐ฟ Core system configuration complete! ๐ฟ"
echo "  *** PLEASE REBOOT ***"
