if exists('g:loaded_strip')
    finish
endif
let g:loaded_strip = 1

function! StripTrailingWhitespace()
    " Save cursor position
    let l:save = winsaveview()
    " Remove trailing whitespace
    %s/\v\s+$//e
    " Move cursor to original position
    call winrestview(l:save)
    echo "Stripped trailing whitespace"
endfunction

nnoremap <leader>sw :call StripTrailingWhitespace()<cr>
