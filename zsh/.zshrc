#### ZSH Config  ###############################################################

autoload -Uz compinit promptinit

# Include hidden files:
_comp_options+=(globdots)

# History:
export HISTFILE_ACTUAL="$HOME/.zhistory"
export HISTFILE="$HISTFILE_ACTUAL"
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # Use same colors as LS
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Ultra basic prompt:
PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

# Force the `path` array to be unique:
typeset -U path PATH

#### Util Aliases + Functions ##################################################

alias vi='nvim'
alias e='emacs -nw'
alias em='emacs'

# Git
alias gs='git status'
alias gl='git log -n 8'
alias gll='git log'
alias gg='git log --graph --oneline --all -n 20'
alias ggg='git log --graph --oneline --all'
alias gc='git clean -fdx -i'
alias gi='git log -n 1 --patch'

# Get back to repo root.
groot() {
    if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
        echo "${git_root}"
        pushd "${git_root}"
    fi
}

# Get back to repo root.
troot() {
    if [ -n "$TMUX" ]; then
        if tmux_session_root=$(tmux display -p \#{session_path}); then
            echo ${tmux_session_root}
            pushd "${tmux_session_root}"
        fi
    else
        echo "Not inside tmux."
    fi
}

alias ls='ls --color=auto'
alias la='ls --color=auto -a'
alias ll='ls --color=auto -la'

# Bat: Remove sidebar/linenos
alias bat="bat --style=plain"

# Do not permit "rm" in interactive shell:
rm_if_not_shell() {
  if [[ $- == *i* ]]; then
    # Interactive shell
    printf "\033[91mI'm sorry, Dave. I’m afraid I can’t do that.\33[0m\n"
  else
    # Script
    rm $@
  fi
}
alias rm=rm_if_not_shell

# Re-run last shell command with sudo:
function ffs {
  local last_cmds=$(fc -ln -20 | grep -v -e " *ffs *")
  local last_cmd=$(echo "$last_cmds" | tail -n 1)
  local sudo_cmd="sudo zsh -c '"$last_cmd"'"
  echo $sudo_cmd
  eval $sudo_cmd
}

# Correct git author
alias git_author_priv="git config user.name \"schilkp\"; git config user.email \"schilk.philipp@gmail.com\""
alias git_author_ethz="git config user.name \"schilkp\"; git config user.email \"schilkp@ethz.ch\""

# Activate python venv
activate() {
    if [ "$#" -eq 1 ]; then
        source $1/bin/activate
    elif [ -f env/bin/activate ]; then
        source env/bin/activate
    elif [ -f venv/bin/activate ]; then
        source venv/bin/activate
    elif [ -f .env/bin/activate ]; then
        source .env/bin/activate
    elif [ -f .venv/bin/activate ]; then
        source .venv/bin/activate
    elif [ -f pyproject.toml ] && grep -q "tool.poetry" pyproject.toml ; then
        poetry shell
    fi
}

# Pull clip file from ssh srver
pull_clip() {
    if [ "$#" -eq 1 ]; then
        ssh $1 "cat ~/.ssh_clip.txt" > ~/.ssh_clip.txt
        echo "See ~/.ssh_clip!"
    else
        echo "Require ssh server."
    fi
}

# here
here() {
    if command -v dolphin &> /dev/null
    then
        dolphin . 1>/dev/null 2>/dev/null & disown
    elif command -v thunar &> /dev/null
    then
        thunar 1>/dev/null 2>/dev/null & disown
    elif command -v nautilus &> /dev/null
    then
        nautilus 1>/dev/null 2>/dev/null & disown
    fi
}

incog () {
    if [[ $1 = disable ]] || [[ $1 == d ]]
    then
        echo "Incog Disabled..."
        export HISTFILE="$HISTFILE_ACTUAL"
        if command -v atuin &> /dev/null; then
           add-zsh-hook precmd _atuin_precmd
           add-zsh-hook preexec _atuin_preexec
        fi
    else
        echo "Incog Enabled..."
        export HISTFILE=
        if command -v atuin &> /dev/null; then
          add-zsh-hook -d precmd _atuin_precmd
          add-zsh-hook -d preexec _atuin_preexec
        fi
    fi
}

# SchilkFetch
source ~/dot/scripts/SchilkFetch.bash
SchilkFetch

#### Plugins ###################################################################
# Note: Plugin install/loading can be disabled by touching ~/.zsh/basic_install
if [[ ! -a ~/.zsh/basic_install ]]; then

    RED='\033[0;31m'
    CYAN='\033[0;36m'
    NC='\033[0m'

    if [[ ! -a ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]]; then
        mkdir -p ~/.zsh
        echo "[${CYAN}zshrc${NC}] ${RED}Installing zsh-vi-mode..${NC}"
        git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.zsh/zsh-vi-mode
    fi
    if [[ ! -a ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
        mkdir -p ~/.zsh
        echo "[${CYAN}zshrc${NC}] ${RED}Installing zsh-autosuggestions..${NC}"
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    fi
    if [[ ! -a ~/.zsh/zsh-completions/README.md ]]; then
        mkdir -p ~/.zsh
        echo "[${CYAN}zshrc${NC}] ${RED}Installing zsh-completions..${NC}"
        git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
    fi
    if [[ -r "$HOME/.config/oh-my-posh" ]]; then
        source ~/.config/oh-my-posh/zshrc_init.zsh
    fi

    # Load zsh-vi-mode:
    source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

    # Load zsh zsh-autosuggestions:
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

    # If autin is installed, enable it.
    if command -v atuin &> /dev/null; then
        # Note: Since zsh-vi-mode lazy-loads keybinds, it will overwrite
        # Some of the keybinds set by atuin. The following creates a 'callback'
        # that loads atuin after zsh-vi-mode has applied all keymaps.
        function my_init() {
            eval "$(atuin init zsh --disable-up-arrow)"
        }
        zvm_after_init_commands+=(my_init)
    fi

    # Initialise completion:
    fpath=(~/.zsh/completion $fpath)
    fpath=(~/.zsh/zsh-completion/src $fpath)
    compinit
fi
