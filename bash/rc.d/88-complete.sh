__n2_complete()
{
    local cur opts subcmd

    cur="${COMP_WORDS[COMP_CWORD]}"

    case "${#COMP_WORDS[@]}" in
        2)
            opts="banner clean info reinstall update"
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            ;;
        3)
            subcmd="${COMP_WORDS[COMP_CWORD-1]}"
            case "$subcmd" in
                banner)
                    opts="on off"
                    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                    ;;
                reinstall)
                    opts="--overwrite-all --no-backup --force-legacy"
                    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            ;;
        *)
            subcmd="${COMP_WORDS[1]}"
            case "$subcmd" in
                reinstall)
                    opts="--overwrite-all --no-backup --force-legacy"
                    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            ;;
    esac
}
complete -F __n2_complete n2

__n2_list_hook_labels()
{
    (
        declare -F
    ) | (
        regex='^declare -f n2_hook_label_(.*)$'
        while read line; do
            if [[ "$line" =~ $regex ]]; then
                echo "${BASH_REMATCH[1]}"
            fi
        done
    )
}

__n2_infinite_bash_complete()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"

    case "${#COMP_WORDS[@]}" in
        2)
            local opts="$(__n2_list_hook_labels)"
            COMPREPLY=( $(compgen -W "${opts[*]}" -- "${cur}") )
            ;;
        *)
            COMPREPLY=()
    esac
}
complete -F __n2_infinite_bash_complete __n2_infinite_bash
complete -F __n2_infinite_bash_complete lab
complete -F __n2_infinite_bash_complete bashtrap
