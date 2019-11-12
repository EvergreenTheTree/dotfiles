if has('autocmd')

augroup myautocommands
    autocmd!

    " Automatically open quickfix window when :helpgrep is run
    autocmd QuickFixCmdPost helpgrep copen

    " Remap enter key to follow links in help files
    autocmd FileType help nnoremap <cr> <c-]>
augroup END

endif
