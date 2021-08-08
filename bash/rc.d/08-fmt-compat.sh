function __n2_gray {
  local gray_scale="${1}"
  if ((0 <= gray_scale && gray_scale < 24)); then
    echo $((232 + gray_scale))
  else
    return 1
  fi
}

function __n2_rgb {
  local r="${1}"
  local g="${2}"
  local b="${3}"
  if ((0 <= r && r < 6 && 0 <= g && g < 6 && 0 <= b && b < 6)); then
    echo $((16 + r * 36 + g * 6 + b))
  else
    return 1
  fi
}

N2_FMT_PS1_HOSTNAME_ROOT="$(tput setaf $(__n2_rgb 5 1 1))"
N2_FMT_PS1_HOSTNAME="$(tput setaf $(__n2_rgb 1 4 2))"
N2_FMT_PS1_USERNAME_ROOT="$(tput setaf $(__n2_rgb 5 1 1))"
N2_FMT_PS1_USERNAME="$(tput setaf $(__n2_rgb 1 4 2))"
N2_FMT_PS1_USERHOST_PUNCT_ROOT="$(tput setaf $(__n2_rgb 2 0 1))"
N2_FMT_PS1_USERHOST_PUNCT="$(tput setaf $(__n2_rgb 0 2 1))"
N2_FMT_PS1_CHROOT_ROOT="$(tput setaf $(__n2_rgb 4 1 3))"
N2_FMT_PS1_CHROOT="$(tput setaf $(__n2_rgb 1 4 4))"
N2_FMT_PS1_BG_INDICATOR="$(tput setaf $(__n2_rgb 5 3 0))"
N2_FMT_PS1_SHLVL_INDICATOR="$(tput setaf $(__n2_rgb 2 1 4))"
N2_FMT_PS1_SCREEN_INDICATOR="$(tput setaf $(__n2_rgb 0 3 5))"
N2_FMT_PS1_GIT_INDICATOR="$(tput setaf $(__n2_rgb 5 1 0))"
N2_FMT_PS1_PERM_GOOD="$(tput setaf $(__n2_rgb 1 4 2))"
N2_FMT_PS1_PERM_BAD="$(tput setaf $(__n2_rgb 5 1 2))"
N2_FMT_PS1_CWD="$(tput setaf $(__n2_rgb 0 3 4))"
N2_FMT_PS1_PRIORITY=(
    "$(tput setaf $(__n2_rgb 5 0 1))" "$(tput setaf $(__n2_rgb 5 1 1))"
    "$(tput setaf $(__n2_rgb 4 1 1))" "$(tput setaf $(__n2_rgb 4 2 1))"
    "$(tput setaf $(__n2_rgb 3 2 1))" "$(tput setaf $(__n2_rgb 3 3 1))"
    "$(tput setaf $(__n2_rgb 2 3 1))" "$(tput setaf $(__n2_rgb 2 4 1))"
    "$(tput setaf $(__n2_rgb 1 4 1))" "$(tput setaf $(__n2_rgb 1 5 1))"
)
N2_FMT_PS1_PHYSICAL_CWD="$(tput setaf $(__n2_gray 12))"
N2_FMT_PS1_DOLLAR_HASH="$(tput setaf $(__n2_rgb 5 5 3))"
N2_FMT_PS1_LABEL="$(tput rev; tput setaf $(__n2_rgb 3 3 2))"
N2_FMT_PS1_PREFIX="$(tput setaf $(__n2_rgb 3 3 2))"
N2_FMT_STATUS_OK="$(tput setaf $(__n2_rgb 0 2 1))"
N2_FMT_STATUS_ERROR="$(tput setaf $(__n2_rgb 5 1 2))"
N2_FMT_CMD_EXPANSIONS="$(tput setaf $(__n2_gray 10))"
N2_FMT_FORCE_NEWLINE="$(tput rev; tput setaf $(__n2_rgb 2 2 1))"
N2_FMT_PINNED_KEY="$(tput setaf $(__n2_rgb 3 2 0))"
N2_FMT_PINNED_VALUE="$(tput setaf $(__n2_rgb 1 1 0))"
N2_FMT_PINNED_PUNCT="$(tput setaf $(__n2_gray 8))"

N2_FMT_PS1_HEAD_PREFIX=
N2_FMT_PS1_MID_PREFIX=
N2_FMT_PS1_TAIL_PREFIX=

__N2_FMT_UNDERLINE="$(tput smul)"

function __n2_fmt {
    local fmt_ctrl_seq i zero_width_wrapper
    fmt_ctrl_seq=
    zero_width_wrapper=no
    for i; do
        case "$i" in
            ps1_hostname)
                if [ "$UID" -eq 0 ]; then
                    fmt_ctrl_seq+="$N2_FMT_PS1_HOSTNAME_ROOT"
                else
                    fmt_ctrl_seq+="$N2_FMT_PS1_HOSTNAME"
                fi
                ;;
            ps1_username)
                if [ "$UID" -eq 0 ]; then
                    fmt_ctrl_seq+="$N2_FMT_PS1_USERNAME_ROOT"
                else
                    fmt_ctrl_seq+="$N2_FMT_PS1_USERNAME"
                fi
                ;;
            ps1_userhost_punct)
                if [ "$UID" -eq 0 ]; then
                    fmt_ctrl_seq+="$N2_FMT_PS1_USERHOST_PUNCT_ROOT"
                else
                    fmt_ctrl_seq+="$N2_FMT_PS1_USERHOST_PUNCT"
                fi
                ;;
            ps1_chroot)
                if [ "$UID" -eq 0 ]; then
                    fmt_ctrl_seq+="$N2_FMT_PS1_CHROOT_ROOT"
                else
                    fmt_ctrl_seq+="$N2_FMT_PS1_CHROOT"
                fi
                ;;
            ps1_bg_indicator)
                fmt_ctrl_seq+="$N2_FMT_PS1_BG_INDICATOR"
                ;;
            ps1_shlvl_indicator)
                fmt_ctrl_seq+="$N2_FMT_PS1_SHLVL_INDICATOR"
                ;;
            ps1_screen_indicator)
                fmt_ctrl_seq+="$N2_FMT_PS1_SCREEN_INDICATOR"
                ;;
            ps1_git_indicator)
                fmt_ctrl_seq+="$N2_FMT_PS1_GIT_INDICATOR"
                ;;
            ps1_perm_good)
                fmt_ctrl_seq+="$N2_FMT_PS1_PERM_GOOD"
                ;;
            ps1_perm_bad)
                fmt_ctrl_seq+="$N2_FMT_PS1_PERM_BAD"
                ;;
            ps1_priority_*)
                fmt_ctrl_seq+="${N2_FMT_PS1_PRIORITY[${i#ps1_priority_}]}"
                ;;
            ps1_cwd)
                fmt_ctrl_seq+="$N2_FMT_PS1_CWD"
                ;;
            ps1_physical_cwd)
                fmt_ctrl_seq+="$N2_FMT_PS1_PHYSICAL_CWD"
                ;;
            ps1_dollar_hash)
                fmt_ctrl_seq+="$N2_FMT_PS1_DOLLAR_HASH"
                ;;
            ps1_label)
                fmt_ctrl_seq+="$N2_FMT_PS1_LABEL"
                ;;
            status_ok)
                fmt_ctrl_seq+="$N2_FMT_STATUS_OK"
                ;;
            status_error)
                fmt_ctrl_seq+="$N2_FMT_STATUS_ERROR"
                ;;
            underline)
                fmt_ctrl_seq+="$__N2_FMT_UNDERLINE"
                ;;
            cmd_expansions)
                fmt_ctrl_seq+="$N2_FMT_CMD_EXPANSIONS"
                ;;
            force_newline)
                fmt_ctrl_seq+="$N2_FMT_FORCE_NEWLINE"
                ;;
            pinned_key)
                fmt_ctrl_seq+="$N2_FMT_PINNED_KEY"
                ;;
            pinned_value)
                fmt_ctrl_seq+="$N2_FMT_PINNED_VALUE"
                ;;
            pinned_punct)
                fmt_ctrl_seq+="$N2_FMT_PINNED_PUNCT"
                ;;
            zero_width)
                zero_width_wrapper=yes
                ;;
        esac
    done

    [ "$zero_width_wrapper" = yes ] && builtin echo -n $'\001'
    builtin echo -n "$fmt_ctrl_seq"
    [ "$zero_width_wrapper" = yes ] && builtin echo -n $'\002'

    return 0
}

__n2_reset_fmt()
{
    local arg="${1:-}" resetfmt_ctrl_seq=$'\033[0m'

    [ "$arg" = zero_width ] && builtin echo -n $'\001'
    builtin echo -n "$resetfmt_ctrl_seq"
    [ "$arg" = zero_width ] && builtin echo -n $'\002'

    return 0
}

