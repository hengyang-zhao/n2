function __source_site_rc {
    local rc
    for rc in "$__N2_MY_DIR"/bash/rc.d/*.sh ; do
        if [ -r "$rc" ]; then
            source "$rc"
        fi
    done
}
__source_site_rc

