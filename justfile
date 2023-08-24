_default: help

# Install standard configs.
install:
    stow alacritty autorandr bash gdb git gtkwave neovim tmux vim zsh

# Print help message.
help:
    @echo "Dotfiles."
    @just --list

