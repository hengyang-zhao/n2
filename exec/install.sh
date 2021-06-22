#!/usr/bin/env bash

set -euo pipefail

if [ ${BASH_VERSINFO[0]} -lt 4 ]; then
    echo "Your bash version ($BASH_VERSION) is too low."
    echo "Requires at least 4.x."
    exit 1
fi

N2_DIR=$(cd "$(dirname "$0")"; pwd)

RC_LINE="source '$N2_DIR/rc.sh'  # n2 installation"
PROFILE_LINE="source '$N2_DIR/profile.sh'  # n2 installation"

declare -A PLAN=(
    ["$HOME/.bashrc"]=$RC_LINE
    ["$HOME/.bash_profile"]=$PROFILE_LINE
)

print_plan() {
    local k
    for k in "${!PLAN[@]}"; do
        echo "Will append line"
        echo -e "  \033[35m${PLAN[$k]}\033[0m"
        echo -e "  to file \033[1m$k\033[0m"
    done
}

confirm() {
    echo -e "Everything looks good? Hit ENTER to continue, or ^C to cancel."
    read
}

install() {
    local k
    for k in "${!PLAN[@]}"; do
        echo "${PLAN[$k]}" >> "$k"
    done
}

finish() {
    echo -e "\033[1mInstallation complete. Please login again.\033[0m"
}

print_plan
confirm || exit 1
install
finish
