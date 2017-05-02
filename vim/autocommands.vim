if has('autocmd')

" This will set certain options for really large files, which results in
" better performance when editing them.

" What is considered to be a large file (in bytes)
let g:large_file = 1024 * 1024 * 15

function! s:LargeFileSetOptions()
    setlocal noswapfile
    setlocal bufhidden=unload
    setlocal readonly
    setlocal eventignore+=Filetype
    setlocal undolevels=-1
endfunction

augroup myautocommands
    autocmd!

    " Detect large files and set the appropriate options.
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) >
                \ g:large_file | call <SID>LargeFileSetOptions() | endif

    " Automatically open quickfix window when :helpgrep is run
    autocmd QuickFixCmdPost helpgrep copen
augroup END

endif
