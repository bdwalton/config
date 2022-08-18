#!/bin/bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit


BARNAME="i3main"
LOGFILE="/tmp/polybar-${BARNAME}.log"

echo "---" | tee -a "${LOGFILE}"
polybar --config=~/.config/polybar/config.ini "${BARNAME}" 2>&1 | tee -a "${LOGFILE}" & disown
