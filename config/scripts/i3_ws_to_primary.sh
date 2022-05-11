#!/bin/sh

# Moves a whole workspace to a primary screen.
# https://faq.i3wm.org/question/5753/move-workspace-to-primary-screen/index.html

PRIMARY_SCREEN=$(xrandr -q | awk '/ connected primary/ {print $1}')
if [ -n "$PRIMARY_SCREEN" ]; then
  i3-msg "Move workspace to output $PRIMARY_SCREEN"
else
  i3-nagbar -m 'No primary screen defined' -t warning
fi
