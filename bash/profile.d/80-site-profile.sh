function __source_site_profile {
    local profile m2_dir
    for m2_dir in "${__M2_DIRS[@]}"; do
        for profile in "$m2_dir"/bash/profile.d/*.sh ; do
            if [ -r "$profile" ]; then
                __n2_source "$profile"
            fi
        done
    done
}
__source_site_profile
