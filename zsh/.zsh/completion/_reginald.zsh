#compdef reginald

autoload -U is-at-least

_reginald() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_reginald_commands" \
"*::: :->reginald" \
&& ret=0
    case $state in
    (reginald)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:reginald-command-$line[1]:"
        case $line[1] in
            (gen)
_arguments "${_arguments_options[@]}" \
'-i+[Input yaml or (h)json listing file path]:INPUT:_files' \
'-o+[Output file path]:OUTPUT:_files' \
'--verify[Verify that existing output file is up-to-date]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_reginald__gen_commands" \
"*::: :->gen" \
&& ret=0

    case $state in
    (gen)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:reginald-gen-command-$line[1]:"
        case $line[1] in
            (c-funcpack)
_arguments "${_arguments_options[@]}" \
'--field-enum-prefix=[Prefix the name of a local field enum with the name of the containing register]:FIELD_ENUM_PREFIX:(true false)' \
'--registers-as-bitfields=[Make register structs bitfields to reduce their memory size]:REGISTERS_AS_BITFIELDS:(true false)' \
'--clang-format-guard=[Surround header with a clang-format off guard]:CLANG_FORMAT_GUARD:(true false)' \
'--generate-enums=[Generate field/shared enums]:GENERATE_ENUMS:(true false)' \
'--generate-registers=[Generate register structs and property defines]:GENERATE_REGISTERS:(true false)' \
'--generate-register-functions=[Generate register packing and unpacking functions]:GENERATE_REGISTER_FUNCTIONS:(true false)' \
'--generate-generic-macros=[Generate generic register packing and unpacking macros]:GENERATE_GENERIC_MACROS:(true false)' \
'--generate-validation-functions=[Generate enum and struct unpacking validation functions]:GENERATE_VALIDATION_FUNCTIONS:(true false)' \
'*--add-include=[Header file that should be included at the top of the generated header]:ADD_INCLUDE: ' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(c-macromap)
_arguments "${_arguments_options[@]}" \
'--clang-format-guard=[Surround header with a clang-format off guard]:CLANG_FORMAT_GUARD:(true false)' \
'*--add-include=[Header file that should be included at the top of the generated header]:ADD_INCLUDE: ' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(md-datasheet)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(md-regdump-decode)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
':map -- Path to YAML register dump file:_files' \
&& ret=0
;;
(rs-nodeps)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_reginald__gen__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:reginald-gen-help-command-$line[1]:"
        case $line[1] in
            (c-funcpack)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(c-macromap)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(md-datasheet)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(md-regdump-decode)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(rs-nodeps)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(completion)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
':shell:(bash elvish fish powershell zsh)' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_reginald__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:reginald-help-command-$line[1]:"
        case $line[1] in
            (gen)
_arguments "${_arguments_options[@]}" \
":: :_reginald__help__gen_commands" \
"*::: :->gen" \
&& ret=0

    case $state in
    (gen)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:reginald-help-gen-command-$line[1]:"
        case $line[1] in
            (c-funcpack)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(c-macromap)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(md-datasheet)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(md-regdump-decode)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(rs-nodeps)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(completion)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
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

(( $+functions[_reginald_commands] )) ||
_reginald_commands() {
    local commands; commands=(
'gen:Generate register management code from register listing' \
'completion:Print completion script for specified shell' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'reginald commands' commands "$@"
}
(( $+functions[_reginald__gen__c-funcpack_commands] )) ||
_reginald__gen__c-funcpack_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen c-funcpack commands' commands "$@"
}
(( $+functions[_reginald__gen__help__c-funcpack_commands] )) ||
_reginald__gen__help__c-funcpack_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen help c-funcpack commands' commands "$@"
}
(( $+functions[_reginald__help__gen__c-funcpack_commands] )) ||
_reginald__help__gen__c-funcpack_commands() {
    local commands; commands=()
    _describe -t commands 'reginald help gen c-funcpack commands' commands "$@"
}
(( $+functions[_reginald__gen__c-macromap_commands] )) ||
_reginald__gen__c-macromap_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen c-macromap commands' commands "$@"
}
(( $+functions[_reginald__gen__help__c-macromap_commands] )) ||
_reginald__gen__help__c-macromap_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen help c-macromap commands' commands "$@"
}
(( $+functions[_reginald__help__gen__c-macromap_commands] )) ||
_reginald__help__gen__c-macromap_commands() {
    local commands; commands=()
    _describe -t commands 'reginald help gen c-macromap commands' commands "$@"
}
(( $+functions[_reginald__completion_commands] )) ||
_reginald__completion_commands() {
    local commands; commands=()
    _describe -t commands 'reginald completion commands' commands "$@"
}
(( $+functions[_reginald__help__completion_commands] )) ||
_reginald__help__completion_commands() {
    local commands; commands=()
    _describe -t commands 'reginald help completion commands' commands "$@"
}
(( $+functions[_reginald__gen_commands] )) ||
_reginald__gen_commands() {
    local commands; commands=(
'c-funcpack:C header with register structs, and packing/unpacking functions' \
'c-macromap:C header with field mask/shift macros' \
'md-datasheet:Markdown datasheet' \
'md-regdump-decode:Decode register dump' \
'rs-nodeps:Rust module with no dependency' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'reginald gen commands' commands "$@"
}
(( $+functions[_reginald__help__gen_commands] )) ||
_reginald__help__gen_commands() {
    local commands; commands=(
'c-funcpack:C header with register structs, and packing/unpacking functions' \
'c-macromap:C header with field mask/shift macros' \
'md-datasheet:Markdown datasheet' \
'md-regdump-decode:Decode register dump' \
'rs-nodeps:Rust module with no dependency' \
    )
    _describe -t commands 'reginald help gen commands' commands "$@"
}
(( $+functions[_reginald__gen__help_commands] )) ||
_reginald__gen__help_commands() {
    local commands; commands=(
'c-funcpack:C header with register structs, and packing/unpacking functions' \
'c-macromap:C header with field mask/shift macros' \
'md-datasheet:Markdown datasheet' \
'md-regdump-decode:Decode register dump' \
'rs-nodeps:Rust module with no dependency' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'reginald gen help commands' commands "$@"
}
(( $+functions[_reginald__gen__help__help_commands] )) ||
_reginald__gen__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen help help commands' commands "$@"
}
(( $+functions[_reginald__help_commands] )) ||
_reginald__help_commands() {
    local commands; commands=(
'gen:Generate register management code from register listing' \
'completion:Print completion script for specified shell' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'reginald help commands' commands "$@"
}
(( $+functions[_reginald__help__help_commands] )) ||
_reginald__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'reginald help help commands' commands "$@"
}
(( $+functions[_reginald__gen__help__md-datasheet_commands] )) ||
_reginald__gen__help__md-datasheet_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen help md-datasheet commands' commands "$@"
}
(( $+functions[_reginald__gen__md-datasheet_commands] )) ||
_reginald__gen__md-datasheet_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen md-datasheet commands' commands "$@"
}
(( $+functions[_reginald__help__gen__md-datasheet_commands] )) ||
_reginald__help__gen__md-datasheet_commands() {
    local commands; commands=()
    _describe -t commands 'reginald help gen md-datasheet commands' commands "$@"
}
(( $+functions[_reginald__gen__help__md-regdump-decode_commands] )) ||
_reginald__gen__help__md-regdump-decode_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen help md-regdump-decode commands' commands "$@"
}
(( $+functions[_reginald__gen__md-regdump-decode_commands] )) ||
_reginald__gen__md-regdump-decode_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen md-regdump-decode commands' commands "$@"
}
(( $+functions[_reginald__help__gen__md-regdump-decode_commands] )) ||
_reginald__help__gen__md-regdump-decode_commands() {
    local commands; commands=()
    _describe -t commands 'reginald help gen md-regdump-decode commands' commands "$@"
}
(( $+functions[_reginald__gen__help__rs-nodeps_commands] )) ||
_reginald__gen__help__rs-nodeps_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen help rs-nodeps commands' commands "$@"
}
(( $+functions[_reginald__gen__rs-nodeps_commands] )) ||
_reginald__gen__rs-nodeps_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen rs-nodeps commands' commands "$@"
}
(( $+functions[_reginald__help__gen__rs-nodeps_commands] )) ||
_reginald__help__gen__rs-nodeps_commands() {
    local commands; commands=()
    _describe -t commands 'reginald help gen rs-nodeps commands' commands "$@"
}

if [ "$funcstack[1]" = "_reginald" ]; then
    _reginald "$@"
else
    compdef _reginald reginald
fi

# reginald 0.0.3
