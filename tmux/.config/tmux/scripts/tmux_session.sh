#!/usr/bin/sh

selected=$(                                                                                    \
    {                                                                                          \
      find ~/es ~/patch-it -mindepth 1 -maxdepth 3 -type d &&                                  \
      find ~/reps          -mindepth 1 -maxdepth 1 -type d &&                                  \
      find ~/dotfiles      -mindepth 0 -maxdepth 1 -type d &&                                  \
      realpath ~/calc &&                                                                       \
      echo "main";                                                                             \
    }                                                                                          \
    | grep -v -F -e ".bfg-report" -e "__pycache__"   `# Remove pointless files.`               \
    | grep -v -e "\.git\($\|/\)"                     `# Remove .git and .git/ but not .github` \
    | xargs -L 1 realpath --relative-to="${HOME}"    `# Remove path to home directory.`        \
    | fzf --reverse                                  `# Picker.`
)

# Exit if nothing selected:
if [ -z "$selected" ]; then
    exit 0
fi

# If "main" was selected, set path to home. Otherwise, set path to selected directory:
if [ "$selected" = "main" ]; then
    selected_path="${HOME}"
else
    selected_path=$(echo "${selected}" | sed -E "sQ^Q${HOME}/Q")
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [ -z "$TMUX" ] && [ -z "$tmux_running" ]; then
    tmux new-session -s "$selected_name" -c "$selected_path"
    exit 0
fi

if ! tmux has-session -t="$selected_name" 2> /dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected_path"
fi

tmux switch-client -t "$selected_name"
