#!/usr/bin/sh

selected=$(                                                   \
    {                                                         \
      find ~/es ~/patch-it -mindepth 1 -maxdepth 3 -type d && \
      find ~/reps          -mindepth 1 -maxdepth 1 -type d && \
      find ~/dotfiles      -mindepth 0 -maxdepth 1 -type d;   \
    }                                                         \
    | grep -v -F -e ".git" -e ".bfg-report" -e "__pycache__"  \
    | fzf                                                     \
)

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
