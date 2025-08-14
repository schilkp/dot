#!/bin/zsh

function completion_from_command() {
    local CMD=$1
    local CMD_GEN=$2

    local RED='\033[0;31m'
    local CYAN='\033[0;36m'
    local NC='\033[0m'

    OUTPUT_TEMP="${HOME}/.zsh/completion/_${CMD}.zsh.tmp"
    OUTPUT="${HOME}/.zsh/completion/_${CMD}.zsh"

    mkdir -p ~/.zsh
    mkdir -p ~/.zsh/completion

    echo "${CYAN}Updating completion for '${CMD}'..${NC}"

    if ! command -v ${CMD} &> /dev/null; then
        echo "${RED} Error: Command '${CMD}' was not found.${NC}"
        return 1
    fi

    echo "${CMD_GEN}"
    eval "${CMD_GEN}" > "${OUTPUT_TEMP}" 2> /dev/null || {
        rm "${OUTPUT_TEMP}"
        echo "${RED} Error: Command '${CMD_GEN}' failed.${NC}"
        return 1
    }

    echo "${CMD} --version"
    local VERSION
    VERSION=$(eval "${CMD} --version") || {
        rm "${OUTPUT_TEMP}"
        echo "${RED} Error: Command '${CMD} --version' failed.${NC}"
        return 1
    }

    echo "" >> "${OUTPUT_TEMP}"
    echo "# ${VERSION}" >> "${OUTPUT_TEMP}"

    mv "${OUTPUT_TEMP}" "${OUTPUT}"

    echo "${CYAN} OK!${NC}"
    return 1
}

completion_from_command "just" "just --completions zsh"
completion_from_command "bender" "bender completion zsh"
completion_from_command "reginald" "reginald completion zsh"
completion_from_command "tband-cli" "tband-cli completion zsh"
completion_from_command "cspect" "cspect completion zsh"
completion_from_command "oh-my-posh" "oh-my-posh completion zsh"
