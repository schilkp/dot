#compdef cspect

autoload -U is-at-least

_cspect() {
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
":: :_cspect_commands" \
"*::: :->cspect" \
&& ret=0
    case $state in
    (cspect)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cspect-command-$line[1]:"
        case $line[1] in
            (annotate)
_arguments "${_arguments_options[@]}" : \
'-o+[Location to store annotated trace (default\: overwrite)]:OUTPUT:_files' \
'--output=[Location to store annotated trace (default\: overwrite)]:OUTPUT:_files' \
'--addr2line=[Convert \$a2l-annotated addresses to lines using given elf file]:ADDR2LINE:_files' \
'--disasm[Disassemble \$da_*-annotated instructions]' \
'--open[Open annotated trace in perfetto]' \
'--serve[Serve annotated trace for perfetto]' \
'-h[Print help]' \
'--help[Print help]' \
':input -- Perfetto trace file to convert:_files' \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
':shell -- Style of completion script to generate:(bash elvish fish powershell zsh)' \
&& ret=0
;;
(open)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
':input -- Perfetto trace file to be opened:_files' \
&& ret=0
;;
(serve)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
':input -- Perfetto trace file to be served:_files' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_cspect__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cspect-help-command-$line[1]:"
        case $line[1] in
            (annotate)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(open)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(serve)
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

(( $+functions[_cspect_commands] )) ||
_cspect_commands() {
    local commands; commands=(
'annotate:Annotate Trace' \
'completion:Print completion script for specified shell' \
'open:Open trace file in perfetto' \
'serve:Serve trace file for perfetto' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cspect commands' commands "$@"
}
(( $+functions[_cspect__annotate_commands] )) ||
_cspect__annotate_commands() {
    local commands; commands=()
    _describe -t commands 'cspect annotate commands' commands "$@"
}
(( $+functions[_cspect__completion_commands] )) ||
_cspect__completion_commands() {
    local commands; commands=()
    _describe -t commands 'cspect completion commands' commands "$@"
}
(( $+functions[_cspect__help_commands] )) ||
_cspect__help_commands() {
    local commands; commands=(
'annotate:Annotate Trace' \
'completion:Print completion script for specified shell' \
'open:Open trace file in perfetto' \
'serve:Serve trace file for perfetto' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cspect help commands' commands "$@"
}
(( $+functions[_cspect__help__annotate_commands] )) ||
_cspect__help__annotate_commands() {
    local commands; commands=()
    _describe -t commands 'cspect help annotate commands' commands "$@"
}
(( $+functions[_cspect__help__completion_commands] )) ||
_cspect__help__completion_commands() {
    local commands; commands=()
    _describe -t commands 'cspect help completion commands' commands "$@"
}
(( $+functions[_cspect__help__help_commands] )) ||
_cspect__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'cspect help help commands' commands "$@"
}
(( $+functions[_cspect__help__open_commands] )) ||
_cspect__help__open_commands() {
    local commands; commands=()
    _describe -t commands 'cspect help open commands' commands "$@"
}
(( $+functions[_cspect__help__serve_commands] )) ||
_cspect__help__serve_commands() {
    local commands; commands=()
    _describe -t commands 'cspect help serve commands' commands "$@"
}
(( $+functions[_cspect__open_commands] )) ||
_cspect__open_commands() {
    local commands; commands=()
    _describe -t commands 'cspect open commands' commands "$@"
}
(( $+functions[_cspect__serve_commands] )) ||
_cspect__serve_commands() {
    local commands; commands=()
    _describe -t commands 'cspect serve commands' commands "$@"
}

if [ "$funcstack[1]" = "_cspect" ]; then
    _cspect "$@"
else
    compdef _cspect cspect
fi

# cspect 0.0.0
