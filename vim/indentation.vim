" Automatically indent when creating new line
set autoindent

" Easily change indentation width
function! SetIndentWidth(width)
    let &shiftwidth = a:width
    let &softtabstop = &shiftwidth
    let &tabstop = &shiftwidth
endfunction

call SetIndentWidth(4)

" Use spaces instead of tabs
set expandtab
