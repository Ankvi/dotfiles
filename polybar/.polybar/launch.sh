#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar for each connected monitor
if type "xrandr"; then
  PRIMARY=$(xrandr -q | grep "primary" | cut -d " " -f1)
  for m in $(xrandr --query | grep " connected" | cut -d " " -f1); do
    if [[ $m == $PRIMARY ]]; then
        MONITOR=$m polybar -q primary -c "$DIR"/config.ini &
    else
        MONITOR=$m polybar -q secondary -c "$DIR"/config.ini &
    fi
  done
else
polybar -q main -c "$DIR"/config.ini &
# polybar -q systemtray -c "$DIR"/config.ini &
fi