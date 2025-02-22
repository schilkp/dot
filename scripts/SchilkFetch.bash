#!/bin/bash
# set -euo pipefail

# Same/Similar 256-color codes used in p10k:
C_GIT="\e[38;5;31m"
C_OK="\e[38;5;76m"
C_WARN="\e[38;5;220m"
C_ERR="\e[38;5;160m"

C_OFF="\x1b[0m"

# Arg1: Name
# Arg2: Repo path
function SchilkFetch_repo_status() {
    # Name:
    printf "%b %s: %b" "$C_GIT" "$1" "$C_OFF"

    REPO_DIRTY=$(git -C "$2" status --porcelain)
    if [ -z "$REPO_DIRTY" ]; then
        printf "%b%b " "$C_OK" "$C_OFF"
    else
        printf "%b%b " "$C_ERR" "$C_OFF"
    fi

    REPO_AHEAD=$(git -C "$2" status -sb | head -n 1 | grep "ahead")
    REPO_BEHIND=$(git -C "$2" status -sb | head -n 1 | grep "behind")
    if [ -z "$REPO_BEHIND" ] && [ -z "$REPO_AHEAD" ]; then
        # In sync.
        printf "%b %b" "$C_OK" "$C_OFF"
    fi
    if [ -n "$REPO_BEHIND" ]; then
        # Behind.
        printf "%b %b" "$C_WARN" "$C_OFF"
    fi
    if [ -n "$REPO_AHEAD" ]; then
        # Ahead.
        printf "%b %b" "$C_WARN" "$C_OFF"
    fi
}


function SchilkFetch() {
    printf "📦 "
    SchilkFetch_repo_status dot "$HOME/dot"
    if [ -d "$HOME/dot_priv" ]; then
        printf "🏡 "
        SchilkFetch_repo_status dot_priv "$HOME/dot_priv"
    fi
    printf "\n"
}

# Only run in the second shell.
# This is usually the first terminal that gets opened, since my META-ENTER runs
# alacritty (with a zsh shell), then opens tmux with another zsh shell inside.
function SchilkFetch_auto() {
    LIVE_COUNTER=$(ps a | awk '{print $2}' | grep -vi "tty" | uniq | wc -l);
    if [ "$LIVE_COUNTER" -eq 2 ]; then
        SchilkFetch
    fi
}
