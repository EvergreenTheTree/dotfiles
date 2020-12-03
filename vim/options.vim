""" BUILTIN OPTIONS
" Make backspace work
set backspace=indent,eol,start

" Better display for messages
set cmdheight=2

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
"""" Airline
" I like this theme, minimalist is good too
let g:airline_theme = "distinguished"

" No powerline symbols up in here
let g:airline_symbols_ascii = 1

" Don't like the default line/col display, use the one from my old statusline
let g:airline_section_z = "%l/%L-%v %P"

" Only enable airline extensions as I need them.
let g:airline_extensions = ["branch", "fugitiveline", "tabline"]

" Don't show a bufferlist when only tab is open
let g:airline#extensions#tabline#show_buffers = 0

" Show tabs when only one tab is open
let g:airline#extensions#tabline#show_tabs = 1

" Show the tab index instead of the number of splits in the tab
let g:airline#extensions#tabline#tab_nr_type = 1

" Don't need a label for tabs
let g:airline#extensions#tabline#tabs_label = ''

" Custom mode names, mainly to make all the insert modes the same
let g:airline_mode_map = {
            \ '__' : '------',
            \ 'c'  : 'COMMAND',
            \ 'i'  : 'INSERT',
            \ 'ic' : 'INSERT',
            \ 'ix' : 'INSERT',
            \ 'multi' : 'MULTI',
            \ 'n'  : 'NORMAL',
            \ 'ni' : '(INSERT)',
            \ 'no' : 'OP PENDING',
            \ 'R'  : 'REPLACE',
            \ 'Rv' : 'V REPLACE',
            \ 's'  : 'SELECT',
            \ 'S'  : 'S-LINE',
            \ '' : 'S-BLOCK',
            \ 't'  : 'TERMINAL',
            \ 'v'  : 'VISUAL',
            \ 'V'  : 'V-LINE',
            \ '' : 'V-BLOCK',
            \ }

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

"""" coc
inoremap <silent><expr> <tab>
            \ pumvisible() ? "\<c-n>" :
            \ <sid>check_back_space() ? "\<tab>" :
            \ coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

function! Coc_mappings()
    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references) code

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    " xmap <leader>f  <Plug>(coc-format-selected)
    " nmap <leader>f  <Plug>(coc-format-selected)
endf

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"""" Dirvish
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

"""" FZF
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>

"""" incsearch
" Replace default mappings with incsearch mappings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Don't save search error messages to message history
let g:incsearch#do_not_save_error_message_history = 1

" Use very magic mode by default
let g:incsearch#magic = '\v'

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

"" vim:fdm=expr:fdl=0:fdc=3:
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
