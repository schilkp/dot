#!/bin/bash
trap "killall waybar" EXIT

FILES="$HOME/.config/niri/waybar/config.jsonc $HOME/.config/niri/waybar/style.css"

while true; do
    waybar -c "$HOME/.config/niri/waybar/config.jsonc" -s "$HOME/.config/niri/waybar/style.css" &
    inotifywait -e create,modify $FILES
    killall waybar
done
