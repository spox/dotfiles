#!/bin/bash

delete_lock_dir(){
    trap 'rm -rf "$lockdir"' 0
}

blur_image(){
    # Write PID of current process so we can kill it later
    echo "$$" > $lockdir/wc_changer.pid

    echo "Now blurring and saving $file as /tmp/.bg.jpg using ImageMagick"
    convert "$file" -scale 50% -blur 0x2.5 -resize 200% /tmp/.bg.jpg
    chmod 0644 /tmp/.bg.jpg
}

set_wallpaper(){
    echo "Setting $file wallpaper using feh"
    feh --no-fehbg --bg-fill "$file"
}

kill_prev_process(){
    echo >&2 "Lock $lockdir detected, killing previous process"
    kill $(cat $lockdir/wc_changer.pid)
}

main(){
    set -e

    # Get random file
    file=$(find ~/.config/wallpapers/*.* -type f -print0 | shuf -z -n 1)

    set_wallpaper

    lockdir=/tmp/wc_changer.lock
    if mkdir "$lockdir"
    then # directory did not exist, but was created successfully
        blur_image
        delete_lock_dir
    else
        kill_prev_process
        delete_lock_dir
        blur_image
    fi
}

main
