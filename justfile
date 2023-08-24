_default: help

# Install standard configs.
install:
    stow alacritty autorandr bash gdb git gtkwave neovim tmux vim zsh

# Status of all system repos.
status:
    @echo ""
    @echo ""
    @echo ""
    @echo "Dotfiles status:"
    @git status
    @echo ""
    @echo ""
    @echo ""
    @echo ""
    @echo "Notes status:"
    @cd ~/notes && git status
    @echo ""
    @echo ""
    @echo ""

# Print help message.
help:
    @echo "Dotfiles."
    @just --list


