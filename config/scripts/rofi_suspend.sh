#!/bin/env sh

while true
do
    if pgrep -x "rofi" >/dev/null
    then
        echo "Rofi is running, sleep 0.5s"
        sleep 0.5s
    else
        echo "Rofi is not running, suspending now"
        qdbus org.kde.Solid.PowerManagement /org/freedesktop/PowerManagement CanSuspend && qdbus org.kde.Solid.PowerManagement /org/freedesktop/PowerManagement Suspend
        break
    fi
done
