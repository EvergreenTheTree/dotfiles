setlocal ts=2 sw=2 sts=2 expandtab

" Compile C files using :make, even when there is no makefile
if glob('[Mm]akefile') == "" 
    let &mp="gcc -o %< %"
endif

inoremap gd <c-]>
