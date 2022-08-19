#!/bin/bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit


BARNAME="i3main"
LOGFILE="/tmp/polybar-${BARNAME}.log"

echo "--- $(date +%c) ($@) ---" | tee -a "${LOGFILE}"

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload --config=~/.config/polybar/config.ini "${BARNAME}" 2>&1 | tee -a "${LOGFILE}" & disown
  done
else
  polybar --reload  --config=~/.config/polybar/config.ini "${BARNAME}" 2>&1 | tee -a "${LOGFILE}" & disown
fi
