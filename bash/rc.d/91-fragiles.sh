__n2_infinite_bash()
{
    local label=${1:-}
    true
    while [ "$?" != 200 ]; do
        clear
        echo
        echo "+============================================================+"
        echo "|                          Bash Trap                         |"
        echo "+------------------------------------------------------------+"
        echo "| ** This bash session will be RESTARTED on normal exit.     |"
        echo "| ** To escape, use exit code 200.                           |"
        echo "+============================================================+"
        echo
        env N2_PS1_LABEL="$label" bash
    done
    return 0
}
alias bashtrap=__n2_infinite_bash
alias lab=__n2_infinite_bash

function __petar_marinov_cd_func {

    local x2 the_new_dir adir index
    local -i cnt

    the_new_dir="${1:-}"

    if [[ "$the_new_dir" ==  "--" ]]; then
        dirs -v
        return 0
    fi

    [[ -z "$the_new_dir" ]] && the_new_dir="$HOME"

    if [[ "${the_new_dir:0:1}" == '-' ]]; then
        #
        # Extract dir N from dirs
        index="${the_new_dir:1}"
        [[ -z "$index" ]] && index=1
        adir=$(dirs +"$index")
        [[ -z "$adir" ]] && return 1
        the_new_dir="$adir"
    fi

    #
    # '~' has to be substituted by ${HOME}
    [[ "${the_new_dir:0:1}" == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

    #
    # Now change to the new dir and add to the top of the stack
    pushd "${the_new_dir}" > /dev/null
    [[ $? -ne 0 ]] && return 1
    the_new_dir=$(pwd)

    #
    # Trim down everything beyond 11th entry
    popd -n +11 2>/dev/null 1>/dev/null

    #
    # Remove any other occurence of this dir, skipping the top of the stack
    for ((cnt=1; cnt <= 10; cnt++)); do
        x2="$(dirs +${cnt} 2>/dev/null)"
        [[ $? -ne 0 ]] && return 0
        [[ "${x2:0:1}" == '~' ]] && x2="${HOME}${x2:1}"
        if [[ "${x2}" == "${the_new_dir}" ]]; then
            popd -n +"$cnt" 2>/dev/null 1>/dev/null
            cnt=cnt-1
        fi
    done

    return 0
}

alias cd='__n2_verbose_cd'
__n2_verbose_cd() {
    __petar_marinov_cd_func "$@"
    local errno=$?
    local hook=n2_hook_postcd
    if [ $errno -eq 0 ] && [ "${1:-}" != -- ]; then
        [ "$(type -t "$hook")" = function ] && "$hook"
    fi
    return $errno
}

__n2_color_table() {
    local i r g b
    for i in {0..23}; do
        printf "[%4s=%s    %s]" "$i" "$(tput setab $(__n2_gray $i))" "$(tput sgr0)"
        ((i % 6 == 5)) && echo
    done
    for r in {0..5}; do
        for g in {0..5}; do
            for b in {0..5}; do
                printf "[%4s=%s    %s]" "$r$g$b" "$(tput setab $(__n2_rgb $r $g $b))" "$(tput sgr0)"
            done
            echo
        done
    done
}

__paginated_jq() {
    if [ -t 1 ]; then
        command jq -C "$@" | less -FR
    else
        command jq "$@"
    fi
}

__n2_has jq less && alias jq=__paginated_jq

