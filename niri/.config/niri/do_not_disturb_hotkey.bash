#!/usr/bin/env bash

# Fail on error code, unknown var, and propagate errors from pipes:
set -euo pipefail

dnd_active=$(makoctl mode | grep "do-not-disturb" || true)

if [[ $dnd_active ]]; then
    # On -> Off
    makoctl mode -r do-not-disturb
    notify-send 'Do-Not-Disturb: OFF' -u normal
else
    # Off -> On
    notify-send 'Do-Not-Disturb: ON' -u normal
    sleep 1
    makoctl mode -a do-not-disturb
fi
