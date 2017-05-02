if &t_Co > 16 || has("gui_running") " 256 color scheme
    set background=dark
    let g:gruvbox_bold = 0
    let g:gruvbox_italic = 0
    let g:gruvbox_italicize_comments = 0
    let g:gruvbox_undercurl = 0
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_contrast_light = 'hard'
    try
        colorscheme gruvbox
    catch /E185/
        colorscheme spacegray
    endtry
else " 16 color scheme
    colorscheme desert
endif
