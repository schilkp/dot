#### ZSH Config  ###############################################################

autoload -Uz compinit promptinit

# Include hidden files:
_comp_options+=(globdots)

# History:
export HISTFILE="$HOME/.zhistory"
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt HIST_IGNORE_SPACE

# Use same colors as LS:
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

#### Util Aliases + Functions ##################################################

alias vi='nvim'

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


# Re-run last shell command with sudo:
function ffs {
  local last_cmd=$(fc -ln -1)
  local sudo_cmd="sudo zsh -c '"$(fc -ln -1)"'"
  echo $sudo_cmd
  eval $sudo_cmd
}

alias csb="echo 'cool story bro'|cowsay"

# Correct git author
alias git_author_priv="git config user.name \"schilkp\"; git config user.email \"schilk.philipp@gmail.com\""
alias git_author_ethz="git config user.name \"schilkp\"; git config user.email \"schilkp@ethz.ch\""

function journal {
  nvim +"Journal"
}

function note {
  nvim +"Note "$1
}

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

# SchilkFetch
source ~/dotfiles/utils/SchilkFetch.bash
SchilkFetch

#### Plugins ###################################################################
# Note: Plugin install/loading can be disabled by touching ~/.zsh/basic_install
if [[ ! -a ~/.zsh/basic_install ]]; then

    RED='\033[0;31m'
    CYAN='\033[0;36m'
    NC='\033[0m'

    # Download/generate plugins if they are not present:
    if [[ ! -a ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme ]]; then
        mkdir -p ~/.zsh
        echo "[${CYAN}zshrc${NC}] ${RED}Installing p10k..${NC}"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
    fi
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

    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # Load p10k:
    source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
    [[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh

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

