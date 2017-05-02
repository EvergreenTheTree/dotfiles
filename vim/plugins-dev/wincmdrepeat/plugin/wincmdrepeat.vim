if exists('g:loaded_wincmdrepeat')
    finish
endif
let g:loaded_wincmdrepeat = 1

nnoremap <silent> <C-w> :<C-u>call <SID>Wincmd(v:count, getchar())<CR>
nnoremap <silent> Q :<C-u> call <SID>WincmdRepeat(v:count)<CR>

function! s:Wincmd(count, key)
    let if_count = a:count ? a:count : ""
    let g:last_wincmd = "wincmd " . nr2char(a:key)
    execute if_count . g:last_wincmd
endfunction

function! s:WincmdRepeat(count)
    let if_count = a:count ? a:count : ""
    execute if_count . g:last_wincmd
endfunction
