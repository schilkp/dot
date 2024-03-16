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
'*--add-include=[Header file that should be included at the top of the generated header]:ADD_INCLUDE: ' \
'--funcs-static-inline=[Make all functions static inline.]:FUNCS_STATIC_INLINE:(true false)' \
'--funcs-as-prototypes=[Generate function prototypes instead of full implementations.]:FUNCS_AS_PROTOTYPES:(true false)' \
'--validation=[This enables the generation of validation functions/macros that check if a given value can be represented as an enum or struct.]:VALIDATION:(true false)' \
'--clang-format-guard=[Surround file with a clang-format off guard]:CLANG_FORMAT_GUARD:(true false)' \
'--include-guards=[Generate include guard]:INCLUDE_GUARDS:(true false)' \
'--doxy-comments=[Generate doxygen comments.]:DOXY_COMMENTS:(true false)' \
'(--dont-generate)*--only-generate=[Only generate a subset of the elements/sections usually included in a complete output file.]:ONLY_GENERATE:(enums enum-validation-funcs register-structs register-properties register-conversion-funcs register-validation-funcs generic-macros)' \
'(--only-generate)*--dont-generate=[Skip generation of some element/section usually included in a complete output file.]:DONT_GENERATE:(enums enum-validation-funcs register-structs register-properties register-conversion-funcs register-validation-funcs generic-macros)' \
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
(rs-struct-no-deps)
_arguments "${_arguments_options[@]}" \
'--address-type=[Rust type to use for register addresses.]:ADDRESS_TYPE: ' \
'--unpacking-error-msg=[Include static string error messages for unpacking errors.]:UNPACKING_ERROR_MSG:(true false)' \
'--register-block-mods=[Wrap each register block into its own module.]:REGISTER_BLOCK_MODS:(true false)' \
'*--struct-derive=[Trait to derive on all register structs.]:STRUCT_DERIVE: ' \
'*--enum-derive=[Trait to derive on all enums.]:ENUM_DERIVE: ' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
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
(rs-struct-no-deps)
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
(rs-struct-no-deps)
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
'md-regdump-decode:Markdown decode report of register dump' \
'rs-struct-no-deps:Rust module with register structs and no dependencies' \
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
'md-regdump-decode:Markdown decode report of register dump' \
'rs-struct-no-deps:Rust module with register structs and no dependencies' \
    )
    _describe -t commands 'reginald help gen commands' commands "$@"
}
(( $+functions[_reginald__gen__help_commands] )) ||
_reginald__gen__help_commands() {
    local commands; commands=(
'c-funcpack:C header with register structs, and packing/unpacking functions' \
'c-macromap:C header with field mask/shift macros' \
'md-datasheet:Markdown datasheet' \
'md-regdump-decode:Markdown decode report of register dump' \
'rs-struct-no-deps:Rust module with register structs and no dependencies' \
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
(( $+functions[_reginald__gen__help__rs-struct-no-deps_commands] )) ||
_reginald__gen__help__rs-struct-no-deps_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen help rs-struct-no-deps commands' commands "$@"
}
(( $+functions[_reginald__gen__rs-struct-no-deps_commands] )) ||
_reginald__gen__rs-struct-no-deps_commands() {
    local commands; commands=()
    _describe -t commands 'reginald gen rs-struct-no-deps commands' commands "$@"
}
(( $+functions[_reginald__help__gen__rs-struct-no-deps_commands] )) ||
_reginald__help__gen__rs-struct-no-deps_commands() {
    local commands; commands=()
    _describe -t commands 'reginald help gen rs-struct-no-deps commands' commands "$@"
}

if [ "$funcstack[1]" = "_reginald" ]; then
    _reginald "$@"
else
    compdef _reginald reginald
fi

# reginald 0.0.3
