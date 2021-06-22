function __source_site_profile {
    local profile
    for profile in "$(__n2_get_my_root)"/profile.d/*.sh ; do
        if [ -r "$profile" ]; then
            source "$profile"
        fi
    done
}
__source_site_profile
