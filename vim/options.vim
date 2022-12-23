""" BUILTIN OPTIONS
" Make backspace work
set backspace=indent,eol,start

" Better display for messages
set cmdheight=1

" Don't search tags file when using insert completion
set complete=.,w,b,u,i

" Don't show preview with insert completion
set completeopt-=preview

" Ask before quiting without saving
set confirm

" Make it easier to see what line I am on
set cursorline

" Make help window half the size of the terminal window
set helpheight=0

" Allow abandoning of buffers without writing them
set hidden

" Increase length of command/search history
set history=1000

" Ignore case while searching
set ignorecase

" Show first search result while typing
set incsearch

" Highlight search result
set hlsearch

" Disable on vimrc reload
nohlsearch

" Always show status line
set laststatus=2

" Show tabs and trailing whitespace
set list
set listchars=tab:>\ ,extends:>,precedes:<,nbsp:-,trail:-

" Allow modelines
set modeline
set modelineexpr

" Disable mouse
set mouse=

" Don't jump to matching bracket
set noshowmatch

" I never need to use octal with ctrl-a/ctrl-x
set nrformats-=octal

" Line numbers
set number

" Allow recursive searching within current directory using the find command
set path=.,**

" Set completion menu height
set pumheight=10

" Set margin for scrolling and scroll distance when margin is hit
set scrolloff=3
set sidescrolloff=3
set sidescroll=1

" Don't save global options and mappings in session files, I don't usually make
" a habit of creating mappings mid session that I want to use later.
set sessionoptions-=options

" Don't give |ins-completion-menu| messages
set shortmess+=c

" Only ignore case if there are no uppercase letters in pattern
set smartcase

" Allows more tab pages when using the -p option than the default
set tabpagemax=25

" Set text width, lines will automatically wrap at this position
set textwidth=80
let &colorcolumn = &textwidth

" Change timeout between key strokes to something more reasonable
set ttimeout
set ttimeoutlen=100

" I generally have a fast terminal connection
set ttyfast

" Play nicely with coc diagnostic messages
set updatetime=300

" Allow selections beyond end of line when in visual block mode
set virtualedit=block

" Ctrl-Z in a mapping acts like <Tab> on cmdline
set wildcharm=<c-z>

" <BS> <Space> h l <Left> <Right> can change lines
set whichwrap=b,s,h,l,<,>

" Tab completion
set wildmenu
set wildmode=full

""" PLUGIN OPTIONS
"""" ALE
let g:ale_perl_perl_options = '-X -c -Mstrict -Mwarnings -Ilib'
let g:ale_java_checkstyle_config = g:user_config_dir . "/ftplugin/java/google_checks.xml"
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_fixers = {
\   'rust': ['rustfmt']
\}
let g:ale_linters = {
\   'python': ['mypy', 'pylint'],
\   'haskell': ['hie'],
\   'rust': ['cargo', 'rustc']
\}
let g:ale_haskell_hie_executable = 'hie-wrapper'
let g:ale_rust_rustc_options = ''
let g:ale_disable_lsp = 1

nnoremap <localleader>f :ALEFix<cr>

"""" Dirvish
" Put directories on top and sort alphabetically
let g:dirvish_mode = 'sort ir /[^\/]$/ | silent! /^.*[^\/]$/,$ sort i | nohl | 1'


" Vim <7.4 compatibility
let g:dirvish_relative_paths = 1

augroup dirvish_settings
    autocmd!

    " Hide hidden files with 'gh'
    autocmd FileType dirvish nnoremap <silent><buffer>
                \ gh :silent keeppatterns g@\v^\..+$@d<cr>
augroup END

"""" FZF
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>

let g:fzf_layout = { 'down': '40%' }

"""" Matchup
nmap <leader>% <plug>(matchup-z%)
omap <leader>% <Plug>(matchup-o_)<plug>(matchup-z%)
xmap <leader>% <plug>(matchup-z%)

"""" Obsession
map <leader>w :Obsess<cr>
map <leader>q :Obsess!<cr>

"""" Pandoc
if exists('pandoc#loaded')
    autocmd! BufNewFile,BufFilePRe,BufRead *.md set filetype=markdown.pandoc
endif

" Hopefully these will help speed pandoc syntax up
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#use = 0
let g:pandoc#modules#disabled = ["bibliographies"]

"""" sneak
let g:sneak#s_next = 1

"""" SuperTab
function! MyContext()
    let current_line = getline(".")
    let line_before_cursor = current_line[0:col(".")-2]

    if line_before_cursor =~# '\v\/(\w|\-){-}$'
        return "\<c-x>\<c-f>"
    endif

    let ctrlngroups = [".*Comment.*", ".*String.*"]
    let group_regex = '\v' . join(ctrlngroups, '|')

    " TODO: figure out why this doesn't work with comments
    for synID in synstack(line("."), col("."))
        if synIDattr(synIDtrans(synID), "name") =~? group_regex
            return "\<c-n>"
        endif
    endfor

    if &omnifunc != ''
        return "\<c-x>\<c-o>"
    elseif &filetype ==# 'vim'
        return "\<c-x>\<c-v>"
    else
        return "\<c-n>"
    endif
endfunction

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabCompletionContexts = ["MyContext"]

"""" Tagbar
nnoremap <f9> :TagbarToggle<cr>

let g:tagbar_autofocus = 1

"""" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-r><c-j>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetDir=g:user_config_dir . "/UltiSnips"

"""" undotree
nnoremap <f5> :UndotreeToggle<cr>

let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_SplitWidth = 24
let g:undotree_SetFocusWhenToggle = 1

function! g:Undotree_CustomMap()
    map <buffer> j J
    map <buffer> k K
endfunction

""" BACKUP AND UNDO
" Use undo file
set undofile

" Backup files don't play nicely with language servers
set nobackup
set nowritebackup

" Allow undoing changes not made in the current session
let &undodir = g:user_config_dir . '/tmp/undo//'

" Put the view directory in the tmp folder
let &viewdir = g:user_config_dir . '/tmp/view'

" Make those folders automatically if they don't already exist
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

if !isdirectory(expand(&viewdir))
    call mkdir(expand(&viewdir), "p")
endif

" Add this folder to wildignore, since I don't need to edit any files from there
set wildignore+=*/tmp/undo/*

""" STATUS LINE
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

"" vim:fdm=expr:fdl=0:fdc=3:
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
