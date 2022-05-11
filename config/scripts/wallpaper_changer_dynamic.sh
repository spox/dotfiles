#!/bin/bash
# Sets different wallpapers based on time
# Kudos to https://wittchen.io/posts/dynamic-wallpaper-for-i3/

# First run of the script will randomly choose a directory in the ~/pix/walls_dynamic/ and
# will save a path to the $CHOSEN_WALLPAPER_DIR file. See https://gitlab.com/maxnatt/dynamic_wallpapers
# for examples.

# Where path of a currently chosen dir with dynamics wallpapers is stored
CHOSEN_WALLPAPER_DIR=/tmp/.wc_dynamic_dir.txt

set_wallpaper(){
  echo "Setting the $1 wallpaper"
  feh --no-fehbg --bg-fill "$1"
  # Used for Plasma's lockscreen
  cp $1 /tmp/.bg.jpg
  chmod 0644 /tmp/.bg.jpg
}

main(){
  if test -f "$CHOSEN_WALLPAPER_DIR"; then
    echo "Dynamic dir is already chosen"
  else
    find ~/.config/wallpapers/* -type d -print0 | shuf -z -n 1 > $CHOSEN_WALLPAPER_DIR
  fi

  wallpapers_path=$(tr -d '\0' <$CHOSEN_WALLPAPER_DIR)

  hour=$(date +%H)
  time_of_day=$(sunwait poll -23.4134127N 140.9435753E)
  [[ $time_of_day == "DAY" ]] && [ $hour -lt 12 ] && set_wallpaper "$wallpapers_path/morning.jpg"
  [ $hour -gt 11 ] && [ $hour -lt 15 ]            && set_wallpaper "$wallpapers_path/midday.jpg"
  [ $hour -gt 14 ] && [[ $time_of_day == "DAY" ]] && set_wallpaper "$wallpapers_path/dusk.jpg"
  [[ $time_of_day == "NIGHT" ]]                   && set_wallpaper "$wallpapers_path/night.jpg"

  return 0
}

main
