function __source_site_rc {
    local rc m2_dir
    for m2_dir in "${__M2_DIRS[@]}"; do
        for rc in "$m2_dir"/bash/rc.d/*.sh ; do
            if [ -r "$rc" ]; then
                __n2_source "$rc"
            fi
        done
    done
}
__source_site_rc

