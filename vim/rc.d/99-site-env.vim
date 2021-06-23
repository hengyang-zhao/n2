for rc in split(globpath("$__N2_MY_DIR/vim/", "*.vim"), '\n')
    execute "source" rc
endfor

