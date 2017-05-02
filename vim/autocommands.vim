if has('autocmd')

augroup myautocommands
    autocmd!

    " Automatically open quickfix window when :helpgrep is run
    autocmd QuickFixCmdPost helpgrep copen
augroup END

endif
