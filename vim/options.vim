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

"""" cmp
if has('nvim-0.5.0')
lua << EOF
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

local cmp = require("cmp")
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    sources = {
        { name = "ultisnips" },
        { name = "nvim_lsp" },
    },
    -- Configure for <TAB> people
    -- - <TAB> and <S-TAB>: cycle forward and backward through autocompletion items
    -- - <TAB> and <S-TAB>: cycle forward and backward through snippets tabstops and placeholders
    -- - <TAB> to expand snippet when no completion item selected (you don't need to select the snippet from completion item to expand)
    -- - <C-space> to expand the selected snippet from completion menu
    mapping = {
        ["<C-Space>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
                    return vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"))
                end

                vim.fn.feedkeys(t("<C-n>"), "n")
            elseif check_back_space() then
                vim.fn.feedkeys(t("<cr>"), "n")
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.complete_info()["selected"] == -1 and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
                vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"))
            elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.fn.feedkeys(t("<ESC>:call UltiSnips#JumpForwards()<CR>"))
            elseif vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t("<C-n>"), "n")
            elseif check_back_space() then
                vim.fn.feedkeys(t("<tab>"), "n")
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                return vim.fn.feedkeys(t("<C-R>=UltiSnips#JumpBackwards()<CR>"))
            elseif vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t("<C-p>"), "n")
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
})

EOF
endif

"""" Dirvish
" Put directories on top and sort alphabetically
let g:dirvish_mode = 'sort ir /[^\/]$/ | /^.*[^\/]$/,$ sort i | nohl | 1'

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

" Don't save search error messages to message history
let g:incsearch#do_not_save_error_message_history = 1

" Use very magic mode by default
let g:incsearch#magic = '\v'

nmap <leader>% <plug>(matchup-z%)
omap <leader>% <Plug>(matchup-o_)<plug>(matchup-z%)
xmap <leader>% <plug>(matchup-z%)

"""" lspconfig
if has('nvim-0.5.0')
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'gopls', 'pylsp' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
endif

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

"" vim:fdm=expr:fdl=0:fdc=3:
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
