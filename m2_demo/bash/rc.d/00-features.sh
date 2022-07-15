# Enables the status line
#
# N2_ENABLE_STATUS_LINE=yes
#

# Thick separator is often desired in lagacy terminals where underline format
# is not supported. If the thick separator is enabled, a separate terminal line
# will be used for displaying the status line.
#
# N2_THICK_SEPARATOR=no
# N2_THICK_SEPARATOR_CHAR='~'
#

# Enables the command expansion. Command expansion tells the command type
# (builtin, external, etc) and their execution start times.
#
# N2_ENABLE_CMD_EXPANSION=yes
#

# Ensures new command promots always use new lines. If the previous output
# was not ended by a newline character, an explicit indicator will be printed.
#
# N2_ENABLE_EXPLICIT_EOF=no

# Automatically attaches tmux on ssh. Requires N2 installations on both client
# and server sides.
#
# N2_AUTO_ATTACH_TMUX=no
#

# Overrides the current hostname. Needs to be exported, otherwise won't affect
# the tmux status line.
#
# N2_PS1_HOSTNAME=spaceship
# export N2_PS1_HOSTNAME
#

# Whether to report error on unset variables in the interactive bash session.
# A known side effect is being too strict and many completion scripts won't
# work because of this.
#
# N2_REPORT_UNBOUND_VARIABLE=no
#
