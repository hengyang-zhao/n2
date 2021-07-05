function __n2_export_site_exec_path {
    local path
    for path in "${__M2_DIRS[@]}"; do
        PATH="$path/exec:$PATH"
    done
    export PATH
}

__n2_export_site_exec_path
unset -f __n2_export_site_exec_path

