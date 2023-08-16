" Automatically detect '.psASM' files for syntax highlighting

au BufRead,BufNewFile *.psASM set filetype=psASM
au FileType psASM setlocal commentstring=#\ %s

