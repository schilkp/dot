#!/bin/bash
# set -euo pipefail

# Same/Similar 256-color codes used in p10k:
C_GIT="\033[38;5;31m"
C_OK="\033[38;5;76m"
C_WARN="\033[38;5;220m"
C_ERR="\033[38;5;160m"
C_OFF="\033[0m"

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
    elif [ -n "$REPO_BEHIND" ]; then
        # Behind.
        printf "%b %b" "$C_WARN" "$C_OFF"
    else
        # Ahead.
        printf "%b %b" "$C_WARN" "$C_OFF"
    fi
}
function SchilkFetch() {
    if [ -d "$HOME/dot" ]; then
        printf "📦 "
        SchilkFetch_repo_status dot "$HOME/dot"
    fi
    if [ -d "$HOME/dot_priv" ]; then
        printf "🏡 "
        SchilkFetch_repo_status dot_priv "$HOME/dot_priv"
    fi
    echo
}
