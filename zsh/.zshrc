#### ZSH Config  ###############################################################

autoload -Uz compinit promptinit; compinit

# Include hidden files:
_comp_options+=(globdots)

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
alias ga='git add'
alias gl='git log -n 8'
alias gll='git log'
alias ggg='git log --graph --oneline --all'
alias gg='git log --graph --oneline --all -n 20'
alias gc='git clean -fdx -i'

# Get back to repo root, or jump back with popd
groot() {
    if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
        pushd "${git_root}"
    fi
}

alias ls='ls --color=auto'
alias la='ls --color=auto -a'
alias ll='ls --color=auto -la'

# Correct git author
alias git_author_priv="git config user.name \"Philipp Schilk\"; git config user.email \"schilk.philipp@gmail.com\""
alias git_author_ethz="git config user.name \"schilkp\"; git config user.email \"schilkp@student.ethz.ch\""

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
    fi
}

# here
here() {
    if command -v thunar &> /dev/null 
    then
        thunar &
    elif command -v nautilus &> /dev/null 
    then
        nautilus &
    fi
}


#### P10K Instant Load #########################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#### Plugins + Extensions ######################################################

if [[ ! -a ~/.zplug ]]; then
   curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh 
fi
source ${HOME}/.zplug/init.zsh

# Prompt:
zplug romkatv/powerlevel10k, as:theme, depth:1

# VI Style editing:
zplug "jeffreytse/zsh-vi-mode"

# Autocomplete:
zplug "zsh-users/zsh-autosuggestions"

zplug load

#### Load P10K config ##########################################################

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
