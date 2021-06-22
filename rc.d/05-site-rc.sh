function __source_site_rc {
    local rc
    for rc in "$(__n2_get_my_root)"/rc.d/*.sh ; do
        if [ -r "$rc" ]; then
            source "$rc"
        fi
    done
}
__source_site_rc

