" Neovim config file.

" Truecolor baybeee
set termguicolors

if has("win32")
    let g:python3_host_prog = "C:\\Python37\\python.exe"
endif

" Source normal vim config file.
exe "source " . split(&rtp, ',')[0] . "/vimrc"

" Use the escape key to exit terminal mode.
tnoremap <esc> <c-\><c-n>

" Edit normal vim config
exe "nnoremap <leader>ev :e " . g:user_config_dir . "/vimrc<cr>"

" Edit neovim specific config
nnoremap <leader>en :e $MYVIMRC<cr>

" Some commands for opening the terminal in split windows and tabs.
command! STerm split | terminal
command! VTerm vsplit | terminal
command! TTerm tabnew | terminal

autocmd TermOpen * setlocal nonumber

set mouse=a

set background=dark

set laststatus=2
