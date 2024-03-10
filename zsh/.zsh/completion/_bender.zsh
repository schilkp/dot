#compdef bender

autoload -U is-at-least

_bender() {
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
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_bender_commands" \
"*::: :->bender" \
&& ret=0
    case $state in
    (bender)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bender-command-$line[1]:"
        case $line[1] in
            (update)
_arguments "${_arguments_options[@]}" \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'-f[forces fetch of git dependencies]' \
'--fetch[forces fetch of git dependencies]' \
'--no-checkout[Disables checkout of dependencies]' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(path)
_arguments "${_arguments_options[@]}" \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--checkout[Force check out of dependency.]' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
'*::name -- Package names to get the path for:' \
&& ret=0
;;
(parents)
_arguments "${_arguments_options[@]}" \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
':name -- Package names to get the parents for:' \
&& ret=0
;;
(clone)
_arguments "${_arguments_options[@]}" \
'-p+[Relative directory to clone PKG into (default\: working_dir)]: : ' \
'--path=[Relative directory to clone PKG into (default\: working_dir)]: : ' \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
':name -- Package name to clone to a working directory:' \
&& ret=0
;;
(packages)
_arguments "${_arguments_options[@]}" \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'-g[Print the dependencies for each package]' \
'--graph[Print the dependencies for each package]' \
'-f[Do not group packages by topological rank. If the \`--graph\` option is specified, print multiple lines per package, one for each dependency.]' \
'--flat[Do not group packages by topological rank. If the \`--graph\` option is specified, print multiple lines per package, one for each dependency.]' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(sources)
_arguments "${_arguments_options[@]}" \
'*-t+[Filter sources by target]: : ' \
'*--target=[Filter sources by target]: : ' \
'*-p+[Specify package to show sources for]: : ' \
'*--package=[Specify package to show sources for]: : ' \
'*-e+[Specify package to exclude from sources]: : ' \
'*--exclude=[Specify package to exclude from sources]: : ' \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'-f[Flatten JSON struct]' \
'--flatten[Flatten JSON struct]' \
'-n[Exclude all dependencies, i.e. only top level or specified package(s)]' \
'--no-deps[Exclude all dependencies, i.e. only top level or specified package(s)]' \
'--raw[Exports the raw internal source tree.]' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
':completion_shell -- Shell completion script style:(bash elvish fish powershell zsh)' \
&& ret=0
;;
(config)
_arguments "${_arguments_options[@]}" \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(script)
_arguments "${_arguments_options[@]}" \
'*-t+[Only include sources that match the given target]: : ' \
'*--target=[Only include sources that match the given target]: : ' \
'*-D+[Pass an additional define to all source files]: : ' \
'*--define=[Pass an additional define to all source files]: : ' \
'*--vcom-arg=[Pass an argument to vcom calls (vsim/vhdlan/riviera only)]: : ' \
'*--vlog-arg=[Pass an argument to vlog calls (vsim/vlogan/riviera only)]: : ' \
'--vlogan-bin=[Specify a \`vlogan\` command]: : ' \
'--vhdlan-bin=[Specify a \`vhdlan\` command]: : ' \
'--compilation-mode=[Choose compilation mode option\: separate/common]: :(separate common)' \
'*-p+[Specify package to show sources for]: : ' \
'*--package=[Specify package to show sources for]: : ' \
'*-e+[Specify package to exclude from sources]: : ' \
'*--exclude=[Specify package to exclude from sources]: : ' \
'--template=[Path to a file containing the tera template string to be formatted.]: : ' \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--no-default-target[Remove any default targets that may be added to the generated script]' \
'--relative-path[Use relative paths (flist generation only)]' \
'--only-defines[Only output commands to define macros (Vivado only)]' \
'--only-includes[Only output commands to define include directories (Vivado only)]' \
'--only-sources[Only output commands to define source files (Vivado only)]' \
'--no-simset[Do not change \`simset\` fileset (Vivado only)]' \
'--no-abort-on-error[Do not abort analysis/compilation on first caught error (only for programs that support early aborting)]' \
'-n[Exclude all dependencies, i.e. only top level or specified package(s)]' \
'--no-deps[Exclude all dependencies, i.e. only top level or specified package(s)]' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
':format -- Format of the generated script:(flist flist-plus vsim vcs verilator synopsys formality riviera genus vivado vivado-sim precision template template_json)' \
&& ret=0
;;
(checkout)
_arguments "${_arguments_options[@]}" \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(vendor)
_arguments "${_arguments_options[@]}" \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
":: :_bender__vendor_commands" \
"*::: :->vendor" \
&& ret=0

    case $state in
    (vendor)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bender-vendor-command-$line[1]:"
        case $line[1] in
            (diff)
_arguments "${_arguments_options[@]}" \
'-e+[Return error code 1 when a diff is encountered. (Optional) override the error message by providing a value.]' \
'--err_on_diff=[Return error code 1 when a diff is encountered. (Optional) override the error message by providing a value.]' \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'-n[Do not apply patches when initializing dependencies]' \
'--no_patch[Do not apply patches when initializing dependencies]' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(patch)
_arguments "${_arguments_options[@]}" \
'*-m+[The message to be associated with the format-patch.]: : ' \
'*--message=[The message to be associated with the format-patch.]: : ' \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--plain[Generate a plain diff instead of a format-patch. Includes all local changes (not only the staged ones).]' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_bender__vendor__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bender-vendor-help-command-$line[1]:"
        case $line[1] in
            (diff)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(patch)
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
(fusesoc)
_arguments "${_arguments_options[@]}" \
'*--license=[Additional commented info (e.g. License) to add to the top of the YAML file.]: : ' \
'--fuse_vendor=[Vendor string to add for generated \`.core\` files]: : ' \
'--fuse_version=[Version string for the top package to add for generated \`.core\` file.]: : ' \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--single[Only create a \`.core\` file for the top package, based directly on the \`Bender.yml\`.]' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
'-d+[Sets a custom root working directory]: : ' \
'--dir=[Sets a custom root working directory]: : ' \
'--local[Disables fetching of remotes (e.g. for air-gapped computers)]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_bender__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bender-help-command-$line[1]:"
        case $line[1] in
            (update)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(path)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(parents)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(clone)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(packages)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(sources)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(config)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(script)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(checkout)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(vendor)
_arguments "${_arguments_options[@]}" \
":: :_bender__help__vendor_commands" \
"*::: :->vendor" \
&& ret=0

    case $state in
    (vendor)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:bender-help-vendor-command-$line[1]:"
        case $line[1] in
            (diff)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(patch)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(fusesoc)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(init)
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

(( $+functions[_bender_commands] )) ||
_bender_commands() {
    local commands; commands=(
'update:Update the dependencies' \
'path:Get the path to a dependency' \
'parents:List packages calling this dependency' \
'clone:Clone dependency to a working directory' \
'packages:Information about the dependency graph' \
'sources:Emit the source file manifest for the package' \
'completion:Emit shell completion script' \
'config:Emit the configuration' \
'script:Emit tool scripts for the package' \
'checkout:Checkout all dependencies referenced in the Lock file' \
'vendor:Copy source code from upstream external repositories into this repository. Functions similar to the lowrisc vendor.py script. Type bender vendor <SUBCOMMAND> --help for more information about the subcommands.' \
'fusesoc:Creates a FuseSoC \`.core\` file for all dependencies where none is present.' \
'init:Initialize a Bender package' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'bender commands' commands "$@"
}
(( $+functions[_bender__checkout_commands] )) ||
_bender__checkout_commands() {
    local commands; commands=()
    _describe -t commands 'bender checkout commands' commands "$@"
}
(( $+functions[_bender__help__checkout_commands] )) ||
_bender__help__checkout_commands() {
    local commands; commands=()
    _describe -t commands 'bender help checkout commands' commands "$@"
}
(( $+functions[_bender__clone_commands] )) ||
_bender__clone_commands() {
    local commands; commands=()
    _describe -t commands 'bender clone commands' commands "$@"
}
(( $+functions[_bender__help__clone_commands] )) ||
_bender__help__clone_commands() {
    local commands; commands=()
    _describe -t commands 'bender help clone commands' commands "$@"
}
(( $+functions[_bender__completion_commands] )) ||
_bender__completion_commands() {
    local commands; commands=()
    _describe -t commands 'bender completion commands' commands "$@"
}
(( $+functions[_bender__help__completion_commands] )) ||
_bender__help__completion_commands() {
    local commands; commands=()
    _describe -t commands 'bender help completion commands' commands "$@"
}
(( $+functions[_bender__config_commands] )) ||
_bender__config_commands() {
    local commands; commands=()
    _describe -t commands 'bender config commands' commands "$@"
}
(( $+functions[_bender__help__config_commands] )) ||
_bender__help__config_commands() {
    local commands; commands=()
    _describe -t commands 'bender help config commands' commands "$@"
}
(( $+functions[_bender__help__vendor__diff_commands] )) ||
_bender__help__vendor__diff_commands() {
    local commands; commands=()
    _describe -t commands 'bender help vendor diff commands' commands "$@"
}
(( $+functions[_bender__vendor__diff_commands] )) ||
_bender__vendor__diff_commands() {
    local commands; commands=()
    _describe -t commands 'bender vendor diff commands' commands "$@"
}
(( $+functions[_bender__vendor__help__diff_commands] )) ||
_bender__vendor__help__diff_commands() {
    local commands; commands=()
    _describe -t commands 'bender vendor help diff commands' commands "$@"
}
(( $+functions[_bender__fusesoc_commands] )) ||
_bender__fusesoc_commands() {
    local commands; commands=()
    _describe -t commands 'bender fusesoc commands' commands "$@"
}
(( $+functions[_bender__help__fusesoc_commands] )) ||
_bender__help__fusesoc_commands() {
    local commands; commands=()
    _describe -t commands 'bender help fusesoc commands' commands "$@"
}
(( $+functions[_bender__help_commands] )) ||
_bender__help_commands() {
    local commands; commands=(
'update:Update the dependencies' \
'path:Get the path to a dependency' \
'parents:List packages calling this dependency' \
'clone:Clone dependency to a working directory' \
'packages:Information about the dependency graph' \
'sources:Emit the source file manifest for the package' \
'completion:Emit shell completion script' \
'config:Emit the configuration' \
'script:Emit tool scripts for the package' \
'checkout:Checkout all dependencies referenced in the Lock file' \
'vendor:Copy source code from upstream external repositories into this repository. Functions similar to the lowrisc vendor.py script. Type bender vendor <SUBCOMMAND> --help for more information about the subcommands.' \
'fusesoc:Creates a FuseSoC \`.core\` file for all dependencies where none is present.' \
'init:Initialize a Bender package' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'bender help commands' commands "$@"
}
(( $+functions[_bender__help__help_commands] )) ||
_bender__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'bender help help commands' commands "$@"
}
(( $+functions[_bender__vendor__help_commands] )) ||
_bender__vendor__help_commands() {
    local commands; commands=(
'diff:Display a diff of the local tree and the upstream tree with patches applied.' \
'init:(Re-)initialize the external dependencies. Copies the upstream files into the target directories and applies existing patches.' \
'patch:Generate a patch file from staged local changes' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'bender vendor help commands' commands "$@"
}
(( $+functions[_bender__vendor__help__help_commands] )) ||
_bender__vendor__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'bender vendor help help commands' commands "$@"
}
(( $+functions[_bender__help__init_commands] )) ||
_bender__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'bender help init commands' commands "$@"
}
(( $+functions[_bender__help__vendor__init_commands] )) ||
_bender__help__vendor__init_commands() {
    local commands; commands=()
    _describe -t commands 'bender help vendor init commands' commands "$@"
}
(( $+functions[_bender__init_commands] )) ||
_bender__init_commands() {
    local commands; commands=()
    _describe -t commands 'bender init commands' commands "$@"
}
(( $+functions[_bender__vendor__help__init_commands] )) ||
_bender__vendor__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'bender vendor help init commands' commands "$@"
}
(( $+functions[_bender__vendor__init_commands] )) ||
_bender__vendor__init_commands() {
    local commands; commands=()
    _describe -t commands 'bender vendor init commands' commands "$@"
}
(( $+functions[_bender__help__packages_commands] )) ||
_bender__help__packages_commands() {
    local commands; commands=()
    _describe -t commands 'bender help packages commands' commands "$@"
}
(( $+functions[_bender__packages_commands] )) ||
_bender__packages_commands() {
    local commands; commands=()
    _describe -t commands 'bender packages commands' commands "$@"
}
(( $+functions[_bender__help__parents_commands] )) ||
_bender__help__parents_commands() {
    local commands; commands=()
    _describe -t commands 'bender help parents commands' commands "$@"
}
(( $+functions[_bender__parents_commands] )) ||
_bender__parents_commands() {
    local commands; commands=()
    _describe -t commands 'bender parents commands' commands "$@"
}
(( $+functions[_bender__help__vendor__patch_commands] )) ||
_bender__help__vendor__patch_commands() {
    local commands; commands=()
    _describe -t commands 'bender help vendor patch commands' commands "$@"
}
(( $+functions[_bender__vendor__help__patch_commands] )) ||
_bender__vendor__help__patch_commands() {
    local commands; commands=()
    _describe -t commands 'bender vendor help patch commands' commands "$@"
}
(( $+functions[_bender__vendor__patch_commands] )) ||
_bender__vendor__patch_commands() {
    local commands; commands=()
    _describe -t commands 'bender vendor patch commands' commands "$@"
}
(( $+functions[_bender__help__path_commands] )) ||
_bender__help__path_commands() {
    local commands; commands=()
    _describe -t commands 'bender help path commands' commands "$@"
}
(( $+functions[_bender__path_commands] )) ||
_bender__path_commands() {
    local commands; commands=()
    _describe -t commands 'bender path commands' commands "$@"
}
(( $+functions[_bender__help__script_commands] )) ||
_bender__help__script_commands() {
    local commands; commands=()
    _describe -t commands 'bender help script commands' commands "$@"
}
(( $+functions[_bender__script_commands] )) ||
_bender__script_commands() {
    local commands; commands=()
    _describe -t commands 'bender script commands' commands "$@"
}
(( $+functions[_bender__help__sources_commands] )) ||
_bender__help__sources_commands() {
    local commands; commands=()
    _describe -t commands 'bender help sources commands' commands "$@"
}
(( $+functions[_bender__sources_commands] )) ||
_bender__sources_commands() {
    local commands; commands=()
    _describe -t commands 'bender sources commands' commands "$@"
}
(( $+functions[_bender__help__update_commands] )) ||
_bender__help__update_commands() {
    local commands; commands=()
    _describe -t commands 'bender help update commands' commands "$@"
}
(( $+functions[_bender__update_commands] )) ||
_bender__update_commands() {
    local commands; commands=()
    _describe -t commands 'bender update commands' commands "$@"
}
(( $+functions[_bender__help__vendor_commands] )) ||
_bender__help__vendor_commands() {
    local commands; commands=(
'diff:Display a diff of the local tree and the upstream tree with patches applied.' \
'init:(Re-)initialize the external dependencies. Copies the upstream files into the target directories and applies existing patches.' \
'patch:Generate a patch file from staged local changes' \
    )
    _describe -t commands 'bender help vendor commands' commands "$@"
}
(( $+functions[_bender__vendor_commands] )) ||
_bender__vendor_commands() {
    local commands; commands=(
'diff:Display a diff of the local tree and the upstream tree with patches applied.' \
'init:(Re-)initialize the external dependencies. Copies the upstream files into the target directories and applies existing patches.' \
'patch:Generate a patch file from staged local changes' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'bender vendor commands' commands "$@"
}

if [ "$funcstack[1]" = "_bender" ]; then
    _bender "$@"
else
    compdef _bender bender
fi
