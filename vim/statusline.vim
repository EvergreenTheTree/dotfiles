set statusline=%!MyStatusline()

function! MyStatusline()
    let statusline = ''
    let filename = expand('%')
    let squeeze_width = winwidth(0) - strlen(filename) / 2

    " Buffer number
    let statusline .= '[%-3.3n] '
    " File name
    if squeeze_width > 50
        let statusline .= '%f '
    endif
    " Window flags
    let statusline .= '%h%w%q'
    if squeeze_width > 50
        " Readonly flag
        let statusline .= '%r'
    endif
    " Modified flag
    let statusline .= '%m'
    " Switch to right side
    let statusline .= '%='
    " Remove these if window width is too small
    if squeeze_width > 50
        " File encoding
        let statusline .= '[' . (strlen(&fenc) ? &fenc : 'none') . ','
        " File format
        let statusline .= &ff . ']'
    endif
    " Filetype
    let statusline .= '%y '
    " Cursor line and total lines
    let statusline .= '%l/%L'
    " Cursor column
    let statusline .= '-%v '
    " Percentage through file
    let statusline .= '%P'

    return statusline
endfunction
