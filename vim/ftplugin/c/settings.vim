let b:detectindent_preferred_expandtab = 1
let b:detectindent_preferred_indent = 2

" Compile C files using :make, even when there is no makefile
if glob('[Mm]akefile') == "" 
    let &mp="gcc -o %< %"
endif
