#compdef tband-cli

autoload -U is-at-least

_tband-cli() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'*-v[]' \
'*--verbose[]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_tband-cli_commands" \
"*::: :->tband-cli" \
&& ret=0
    case $state in
    (tband-cli)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:tband-cli-command-$line[1]:"
        case $line[1] in
            (conv)
_arguments "${_arguments_options[@]}" : \
'-f+[Input format]:FORMAT:(hex bin)' \
'--format=[Input format]:FORMAT:(hex bin)' \
'-m+[TraceMode]:MODE:(bare-metal free-rtos)' \
'--mode=[TraceMode]:MODE:(bare-metal free-rtos)' \
'-c+[Number of cores of target]:CORE_COUNT: ' \
'--core-count=[Number of cores of target]:CORE_COUNT: ' \
'-o+[Location to store converted trace]:OUTPUT:_files' \
'--output=[Location to store converted trace]:OUTPUT:_files' \
'--open[Open converted trace in perfetto]' \
'--serve[Serve converted trace for perfetto]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::input -- Input files with optional core id:' \
&& ret=0
;;
(serve)
_arguments "${_arguments_options[@]}" : \
'--open[Open perfetto in browser]' \
'-h[Print help]' \
'--help[Print help]' \
':input -- Perfetto trace file to be served:_files' \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
':shell -- Style of completion script to generate:(bash elvish fish powershell zsh)' \
&& ret=0
;;
(dump)
_arguments "${_arguments_options[@]}" : \
'-f+[Input format]:FORMAT:(hex bin)' \
'--format=[Input format]:FORMAT:(hex bin)' \
'-m+[TraceMode]:MODE:(bare-metal free-rtos)' \
'--mode=[TraceMode]:MODE:(bare-metal free-rtos)' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':input -- Input file with optional core id:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_tband-cli__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:tband-cli-help-command-$line[1]:"
        case $line[1] in
            (conv)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(serve)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(dump)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_tband-cli_commands] )) ||
_tband-cli_commands() {
    local commands; commands=(
'conv:Convert trace recording' \
'serve:Serve trace file for perfetto' \
'completion:Print completion script for specified shell' \
'dump:Dump trace recording' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'tband-cli commands' commands "$@"
}
(( $+functions[_tband-cli__completion_commands] )) ||
_tband-cli__completion_commands() {
    local commands; commands=()
    _describe -t commands 'tband-cli completion commands' commands "$@"
}
(( $+functions[_tband-cli__conv_commands] )) ||
_tband-cli__conv_commands() {
    local commands; commands=()
    _describe -t commands 'tband-cli conv commands' commands "$@"
}
(( $+functions[_tband-cli__dump_commands] )) ||
_tband-cli__dump_commands() {
    local commands; commands=()
    _describe -t commands 'tband-cli dump commands' commands "$@"
}
(( $+functions[_tband-cli__help_commands] )) ||
_tband-cli__help_commands() {
    local commands; commands=(
'conv:Convert trace recording' \
'serve:Serve trace file for perfetto' \
'completion:Print completion script for specified shell' \
'dump:Dump trace recording' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'tband-cli help commands' commands "$@"
}
(( $+functions[_tband-cli__help__completion_commands] )) ||
_tband-cli__help__completion_commands() {
    local commands; commands=()
    _describe -t commands 'tband-cli help completion commands' commands "$@"
}
(( $+functions[_tband-cli__help__conv_commands] )) ||
_tband-cli__help__conv_commands() {
    local commands; commands=()
    _describe -t commands 'tband-cli help conv commands' commands "$@"
}
(( $+functions[_tband-cli__help__dump_commands] )) ||
_tband-cli__help__dump_commands() {
    local commands; commands=()
    _describe -t commands 'tband-cli help dump commands' commands "$@"
}
(( $+functions[_tband-cli__help__help_commands] )) ||
_tband-cli__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'tband-cli help help commands' commands "$@"
}
(( $+functions[_tband-cli__help__serve_commands] )) ||
_tband-cli__help__serve_commands() {
    local commands; commands=()
    _describe -t commands 'tband-cli help serve commands' commands "$@"
}
(( $+functions[_tband-cli__serve_commands] )) ||
_tband-cli__serve_commands() {
    local commands; commands=()
    _describe -t commands 'tband-cli serve commands' commands "$@"
}

if [ "$funcstack[1]" = "_tband-cli" ]; then
    _tband-cli "$@"
else
    compdef _tband-cli tband-cli
fi

# tband-cli 0.1.0
