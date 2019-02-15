function safe-load {
    local fpath="$1"
    [[ -f $fpath ]] && source $fpath
}


safe-load /usr/share/zsh/vendor-completions/_fzf
safe-load /usr/share/doc/fzf/examples/key-bindings.zsh
