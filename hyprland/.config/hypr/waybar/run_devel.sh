#!/bin/bash
trap "killall waybar" EXIT

FILES="$HOME/.config/hypr/waybar/config.jsonc $HOME/.config/hypr/waybar/style.css"

while true; do
    waybar -c "$HOME/.config/hypr/waybar/config.jsonc" -s "$HOME/.config/hypr/waybar/style.css" &
    inotifywait -e create,modify $FILES
    killall waybar
done
