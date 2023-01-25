function __n2_has {
    for cmd in "$@"; do
        type "$cmd" &>/dev/null || return 1
    done
}

