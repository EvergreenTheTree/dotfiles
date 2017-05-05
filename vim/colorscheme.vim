if &t_Co > 16 || has("gui_running") " 256 color scheme
    set background=dark
    let g:hybrid_custom_term_colors = 1
    colorscheme hybrid
else " 16 color scheme
    colorscheme desert
endif
