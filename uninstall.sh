#!/bin/bash

echo
echo "-----------------------------------------------------------------------"
echo -e "-- To uninstall N2, you need to \033[1;31mMANUALLY EDIT\033[0m the following files to --"
echo "-- remove the code blocks starting with 'n2 installation'.           --"
echo "-----------------------------------------------------------------------"
echo

N2_DIR=$(cd "$(dirname "$0")"; pwd)
INSTALLED_FILES="$N2_DIR/volatile/INSTALLED_FILES"

while read -r line; do
  echo "* $line"
done < "$INSTALLED_FILES"

echo

# TODO: Add an option to allow automated line removal
