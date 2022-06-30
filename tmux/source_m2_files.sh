#!/usr/bin/env bash

shopt -s nullglob

IFS=:
for m2_dir in $__M2_DIRS; do
    for conf in "$m2_dir/tmux"/*; do
        tmux source-file "$conf"
    done
done
