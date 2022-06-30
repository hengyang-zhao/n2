for m2_dir in split($__M2_DIRS, ':')
	for rc in split(globpath(m2_dir . "/vim/", "*.vim"), '\n')
		execute "source" rc
	endfor
endfor
