if has('nvim') || has('gui_running')
    set background=dark
    let g:onedarkhc_terminal_italics = 1
    colorscheme onedarkhc
    " Use the terminal background color as the colorscheme background color
    hi Normal guibg=NONE
elseif &t_Co > 16 " 256 color scheme
    set background=dark
    let g:hybrid_custom_term_colors = 1
    colorscheme hybrid
else " 16 color scheme
    colorscheme desert
endif
