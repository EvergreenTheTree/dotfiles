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
        { name = "path" },
    },
    formatting = {
        format = function (entry, vim_item)
            if not entry.source.source.client then return vim_item end
            local item = entry:get_completion_item()
            local lsp_server = entry.source.source.client.name
            if (lsp_server == "clangd" or lsp_server == "ccls") and item.detail then
                vim_item.menu = item.detail
            end
            return vim_item
        end
    },
    -- Configure for <TAB> people
    -- - <TAB> and <S-TAB>: cycle forward and backward through autocompletion items
    -- - <TAB> and <S-TAB>: cycle forward and backward through snippets tabstops and placeholders
    -- - <TAB> to expand snippet when no completion item selected (you don't need to select the snippet from completion item to expand)
    -- - <C-space> to expand the selected snippet from completion menu
    mapping = {
        ["<Tab>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
                else
                    fallback()
                end
            end
        }),
        ["<S-Tab>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                    return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                    return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
                else
                    fallback()
                end
            end
        }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<C-n>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
        ['<C-p>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i'}),
        ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close() }),
        ['<CR>'] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        }),
    },
})

EOF
endif

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
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', ',D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', ',rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', ',ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- require'completion'.on_attach(client)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls', 'pylsp', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
require'lspconfig'.powershell_es.setup{
  bundle_path = '/opt/powershell-editor-services',
}
require("clangd_extensions").setup()

EOF
endif

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
