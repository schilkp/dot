#/bin/sh

if tmux has-session -t=main 2> /dev/null; then
    tmux switch-client -t main
fi
