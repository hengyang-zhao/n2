#!/usr/bin/env bash

set -euo pipefail

if [ ${BASH_VERSINFO[0]} -lt 4 ]; then
    echo "Your bash version ($BASH_VERSION) is too low."
    echo "Requires at least 4.x."
    exit 1
fi

N2_DIR=$(cd "$(dirname "$0")"; pwd)

BASHRC_PATH="$HOME/.bashrc"
BASH_PROFILE_PATH="$HOME/.bash_profile"
VIMRC_PATH="$HOME/.vimrc"
TMUX_CONF_PATH="$HOME/.tmux.conf"

read -r -d '' BASHRC_SNIP << EOM || true
# n2 installation
source $N2_DIR/bash/rc
EOM

read -r -d '' BASH_PROFILE_SNIP << EOM || true
# n2 installation
source $N2_DIR/bash/profile
EOM

read -r -d '' VIMRC_SNIP << EOM || true
" n2 installation
execute "source" "$N2_DIR/vim/rc"
EOM

read -r -d '' TMUX_CONF_SNIP << EOM || true
# n2 installation
source-file $N2_DIR/tmux/conf
EOM

declare -A PLAN=(
    ["$BASHRC_PATH"]="$BASHRC_SNIP"
    ["$BASH_PROFILE_PATH"]="$BASH_PROFILE_SNIP"
    ["$VIMRC_PATH"]="$VIMRC_SNIP"
    ["$TMUX_CONF_PATH"]="$TMUX_CONF_SNIP"
)

function indent {
    local line p
    p="$1"
    while read -r line; do
        echo "$p$line"
    done
}

function fmt {
    local line p
    p="$1"
    while read -r line; do
        echo -e "\033[${p}m$line\033[0m"
    done
}

print_diff() {
    local path snippet
path="$1"
snippet="$2"
echo "Will apply diff to file $(fmt 1 <<< $path):"
(diff -C10 "$path" <(cat "$path" <(echo "$snippet")) || true) | fmt 34
}

confirm() {
    echo -e "Looks good? Hit ENTER to continue, or ^C to cancel."
    read
}

install() {
    local path snippet
path="$1"
snippet="$2"
	#echo "${snippet}" >> "$path"
echo "Wrote to file $(fmt 1 <<< "$path")."
}

main() {
	local path snippet
for path in ${!PLAN[@]}; do
snippet="${PLAN["$path"]}"
	print_diff "$path" "$snippet"
	confirm || continue
	install "$path" "$snippet"
done

}

main

