function __source_site_profile {
    local profile
    for profile in "$__N2_MY_DIR"/bash/profile.d/*.sh ; do
        if [ -r "$profile" ]; then
            source "$profile"
        fi
    done
}
__source_site_profile
