__n2_source() {
    local path
    path="$1"
    if [ ${N2_DEBUG:-no} = yes ]; then
        echo SOURCE "$path"
    fi
    source "$path"
}
