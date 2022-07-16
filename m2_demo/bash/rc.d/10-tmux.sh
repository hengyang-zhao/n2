# Tmux shortcut: t
#
# To start or attach session `main`:
#
#     t
#
# To start or attach session <NAME>:
#
#     t <NAME>
#
# To list all living sessions:
#
#     t ls
#
# Uncomment below to enable this feature.
#
#
# __n2_has tmux && alias t=__connect_tmux
# function __connect_tmux
# {
#     local arg="${1:-}"
#     case "_$arg" in
#         _)
#             [ "${TMUX_ATTACHED:-no}" != yes ] && tmux new -c ~ -As main
#             ;;
#         _:)
#             tmux ls
#             ;;
#         *)
#             [ "${TMUX_ATTACHED:-no}" != yes ] && tmux new -c ~ -As "$arg"
#             ;;
#     esac
# }
#
