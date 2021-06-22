__n2_load_profiles() {
    local profile
    for profile in "$__N2_DIR"/profile.d/*.sh; do
        source "$profile"
    done
}

__n2_get_root() {
    local source_path
    source_path="$BASH_SOURCE"
    if [ ${source_path:0:1} != / ]; then
        source_path="$(pwd)/$source_path"
    fi
    echo $(dirname "$source_path")
}

__n2_get_my_root() {
    echo "${N2_MY_DIR:-$HOME/.myn2}"
}

__N2_DIR=$(__n2_get_root)
__n2_load_profiles

source "$__N2_DIR"/rc.sh

