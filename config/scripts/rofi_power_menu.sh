#!/bin/env sh

if [ x"$@" = x"Shutdown" ]
then
    qdbus org.kde.ksmserver /KSMServer logout 0 2 3
elif [ x"$@" = x"Suspend" ]
then
    nohup ~/.scripts/rofi_suspend.sh >/dev/null 2>&1 &
    exit 0
elif [ x"$@" = x"Reboot" ]
then
    qdbus org.kde.ksmserver /KSMServer logout 0 1 3
elif [ x"$@" = x"Logout" ]
then
    qdbus org.kde.ksmserver /KSMServer logout 0 0 3
fi

echo -en "\x00prompt\x1fpwr\n"

echo -en "Shutdown\0icon\x1fsystem-shut-down\n"
echo -en "Suspend\0icon\x1fsleep\n"
echo -en "Reboot\0icon\x1fsystem-restart\n"
echo -en "Logout\0icon\x1fxfsm-logout\n"
