set expandtab
call SetIndentWidth(4)

function! SetPython3Opts()
    return 0
endfunction

function! SetPython2Opts()
    return 0
endfunction

function! SetPythonVersion(ver)
    if a:ver == 3
        let b:python_version = 3
        call SetPython3Opts()
    elseif a:ver == 2
        let b:python_version = 2
        call SetPython2Opts()
    else
        echoerr "Invalid python version.  Must either be 2 or 3."
    endif
endfunction

function! TogglePythonVersion()
    if b:python_version == 3
        call SetPythonVersion(2)
        echomsg "Python version for buffer changed to 2"
    elseif b:python_version == 2
        call SetPythonVersion(3)
        echomsg "Python version for buffer changed to 3"
    endif
endfunction

if !exists("b:python_version")
    " Set python 3 as default version
    call SetPythonVersion(3)
endif

" Map it
nnoremap <silent> <localleader>v :call TogglePythonVersion()<cr>

" Poor man's syntastic.  Kinda took this idea from romainl's config.
if executable("pep8")
    setlocal errorformat=%f:%l:%c:\ %m
    setlocal makeprg=pep8
    command! -buffer Make silent make! % | silent redraw! | silent wincmd p
    autocmd! BufWritePost <buffer> Make
endif
