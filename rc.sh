[ -z "$PS1" ] && return

if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

__n2_load_rc() {
    local rc
    for rc in "$__N2_DIR"/rc.d/*.sh; do
        source "$rc"
    done
}

__n2_load_rc
PROMPT_COMMAND=__n2_do_after_command
trap __n2_do_before_command DEBUG

