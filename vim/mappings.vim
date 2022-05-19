" Set leader to space key
let mapleader = "\<space>"

" Set local leader to comma
let maplocalleader = ","

" Easily edit my config files.
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>et :e ~/.config/tmux/tmux.conf<cr>
nnoremap <leader>ez :e ~/.config/zsh/.zshrc<cr>

" Hex read
nnoremap <leader>hr :%!xxd<cr> :set filetype=xxd<cr>

" Hex write
nnoremap <leader>hw :%!xxd -r<cr> :set binary<cr> :set filetype=<cr>

" Quick vimrc reload
nnoremap <leader>R :mkview<cr>:source $MYVIMRC<cr>:loadview<cr>

" Easily open files that can be found in the current directory or subdirectories
" of it.
nnoremap <leader>f :find **/*

" Same, except only include file names instead of relative path
nnoremap <leader>F :find *

" Some mappings which make it faster to replace words throughout a file
nnoremap <leader>; *``cgn
nnoremap <leader>, #``cgN

" Keep keys on home row when exiting insert. I can map capslock to escape on
" some systems, but I am keeping this here for convenience.
inoremap jk <esc>

" Make Y behave more like D
nnoremap Y y$

function! Refresh()
    redraw!
    syntax sync fromstart
endf

" Temporarily disable search highlighting and refresh
nnoremap <silent> <leader><space> :call Refresh()<cr>:nohlsearch<cr>

" Focus current fold.  (close all folds that aren't beneath the cursor)
nnoremap <leader>z zMzv

" I use the system clipboard enough that this is worth it
if has("clipboard")
    nnoremap <leader>p "+p
    nnoremap <leader>P "+P
    nnoremap <leader>y "+y
    vnoremap <leader>y "+y
    vnoremap <leader>p "+p
endif
