#!/bin/bash

CONFIG_FILES="$HOME/.config/waybar/config.jsonc"

trap "killall waybar" EXIT

while true; do
    waybar &
    inotifywait -e create,modify "$CONFIG_FILES"
    killall waybar
done
