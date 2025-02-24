#!/usr/bin/bash
SCRIPT_DIR=$(dirname "$0")

raw_dirs=$(                                                                                        \
      find ~/reps          -mindepth 1 -maxdepth 1 -type d &&                                      \
      find ~/dot           -mindepth 0 -maxdepth 1 -type d &&                                      \
      find ~/Desktop       -mindepth 0 -maxdepth 1 -type d                                         \
)


if [ -L "$SCRIPT_DIR/tmux_session_locs_priv.sh" ] || [ -f "$SCRIPT_DIR/tmux_session_locs_priv.sh" ]; then
    raw_dirs="$raw_dirs
$("$SCRIPT_DIR/tmux_session_locs_priv.sh")"
fi

options_dirs=$(echo "$raw_dirs"                                                                    \
    | grep -v -F -e ".bfg-report" -e "__pycache__"   `# Remove pointless files.`                   \
    | grep -v -e "\.git\($\|/\)"                     `# Remove .git and .git/ but not .github`     \
    | xargs -L 1 realpath -s --relative-to="${HOME}"    `# Remove path to home directory.`         \
    | sed -E "sQ^Q~/Q" \
)

options_sessions=$(tmux list-sessions -F "#{p20:session_name} [#{p-3:session_id}]")

options_others="main"

selected=$(                                                                                        \
    {                                                                                              \
        echo "${options_sessions}" &&                                                              \
        echo "${options_others}" &&                                                                \
        echo "${options_dirs}";                                                                    \
    }                                                                                              \
    | fzf --reverse --scheme=path --tiebreak=index
)

# Exit if nothing selected:
if [ -z "$selected" ]; then
    exit 0
fi

# If an existing session was selected, go to that session:
if [[ $selected =~ \[[[:space:]]*\$[0-9]+\]$ ]];  then
    selected_session=$(echo "$selected" | sed -E 's/ +\[ *\$([0-9]+)\]$//')
    tmux switch-client -t "$selected_session"
    exit
fi

# Go to path-session.

# If "main" was selected, set path to home. Otherwise, set path to selected directory:
if [ "$selected" = "main" ]; then
    selected_path="${HOME}"
else
    selected_path=$(echo "${selected}" | sed -E "sQ^~/Q${HOME}/Q")
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
