#!/usr/bin/env bash
# Set wallpaper based on time of day

BASE_PATH="/home/spox/.config/wallpapers"

function set() {
  echo -n "Setting wallpaper using: ${1}... " >&2
  if feh --no-fehbg --bg-fill "${1}"; then
    echo "done" >&2
    return 0
  else
    echo "FAILED!" >&2
    return 1
  fi
}

function get_file() {
  echo -n "Locating background file in directory ${1}... " >&2
  if [[ -d "${1}" ]]; then
    file="$(ls "${1}/"* | shuf -n 1)"
    echo "${file}"
    short_name="$(basename "${file}")"
    echo "${short_name}" >&2
    return 0
  else
    echo "FAILED!" >&2
    return 1
  fi
}

if [[ "${1}" == "poll" ]]; then
  echo -n "Waiting for sunrise/sunset... " >&2
  sunwait wait > /dev/null 2>&1
  sleep 60 # wait a minute before we change
  echo "ready!" >&2
fi

echo -n "Checking local time... " >&2
time="$(sunwait poll)"
time_val="$?"
if [[ "${time_val}" == "1" ]]; then
  echo "FAILED!" >&2
elif [[ "${time_val}" == "2" ]]; then
  dir="${BASE_PATH}/day"
else
  dir="${BASE_PATH}/night"
fi
echo "${time}" >&2

wallpaper="$(get_file "${dir}")"
set "${wallpaper}"
