set expandtab
call SetIndentWidth(2)

" Compile C files using :make, even when there is no makefile
if glob('[Mm]akefile') == "" 
    let &mp="gcc -o %< %"
endif
