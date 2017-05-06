""" BUILTIN OPTIONS
" Make backspace work
set backspace=indent,eol,start

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
""" Dirvish
" Put directories on top and sort alphabetically
let g:dirvish_mode = 'sort ir /[^\/]$/ | /^.*[^\/]$/,$ sort i | nohl | 1'

" Vim <7.4 compatibility
let g:dirvish_relative_paths = 1

augroup dirvish_settings
    autocmd!

    " Enable fugitive in dirvish buffers
    autocmd FileType dirvish call fugitive#detect(@%)

    " Hide hidden files with 'gh'
    autocmd FileType dirvish nnoremap <silent><buffer>
                \ gh :silent keeppatterns g@\v^\..+$@d<cr>
augroup END

"""" Haskellmode
if executable("/usr/bin/firefox")
    let g:haddock_browser = "/usr/bin/firefox"
endif

let g:haddock_docdir = "/usr/share/doc/ghc/html/"

"""" incsearch
" Replace default mappings with incsearch mappings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Don't save search error messages to message history
let g:incsearch#do_not_save_error_message_history = 1

" Use very magic mode by default
let g:incsearch#magic = '\v'

"""" Pandoc
if exists('pandoc#loaded')
    autocmd! BufNewFile,BufFilePRe,BufRead *.md set filetype=markdown.pandoc
endif

" Hopefully these will help speed pandoc syntax up
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#use = 0

"""" Rust
" Disable default settings
let g:rust_recommended_style = 0

"""" sneak
" Use sneak for f and F
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" Use sneak for t and T
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

"""" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-r><c-j>"
let g:UltiSnipsEditSplit="horizontal"

""" BACKUP AND UNDO
" Use undo file
set undofile

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

"" vim:fdm=expr:fdl=0:fdc=3:
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
