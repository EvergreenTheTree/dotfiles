setlocal ts=2 sw=2 sts=2 expandtab

" Compile C files using :make, even when there is no makefile
if glob('[Mm]akefile') == "" 
    let &mp="gcc -o %< %"
endif

nnoremap gd <c-]>

" Easy source/header switching
if !exists('*SwitchSourceHeader')
    function! SwitchSourceHeader()
        if expand("%:e") == "c"
        find %:t:r.h
        else
        find %:t:r.c
        endif
    endfunction
endif

nnoremap <localleader>s :call SwitchSourceHeader()<cr>

setlocal textwidth=79
