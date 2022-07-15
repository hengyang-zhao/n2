# Automatically types `ls` for you after each `cd`.
#
# function n2_hook_postcd {
#     ls --color=auto
# }
#

# Makes the cwd more colorful --- path separators will be in darker blue.
#
# function n2_hook_ps1_cwd {
#     __n2_inline_echo "$1" | sed \
#         -e 's/\//'"$(tput setaf $(__n2_rgb 0 1 2))"'\/'$'\033'"[22m$(__n2_fmt ps1_cwd)"'/g'
# }
#

# Defines a lab named `universe`. Uncomment (re-source) and try:
#
#     lab <TAB>
#
# or
#
#     lab universe
#
# (couldn't get out? type exit 200)
#
# function n2_hook_label_universe {
#     n2_define_pinned light_speed '299792458 m/s'
#     n2_define_pinned planck_constant '6.62607015e-34 J/Hz'
# }
#

