if ! type oh-my-posh &> /dev/null ; then
    echo "[${CYAN}zshrc${NC}] ${RED}Installing oh-my-posh..${NC}"
    ~/.config/oh-my-posh/install_oh_my_posh.sh -d ~/.local/bin/
fi

if type oh-my-posh &> /dev/null ; then
    eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.yaml)"
fi

