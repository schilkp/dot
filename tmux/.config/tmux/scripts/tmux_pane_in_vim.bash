#!/bin/bash
tmux capture-pane -Jp | sed '/[^[:space:]]/,$!d' | tac | sed '/[^[:space:]]/,$!d' | tac | nvim -
