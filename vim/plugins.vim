" Load matchit plugin that is bundled with vim
runtime macros/matchit.vim

" Use pathogen to manage manually installed plugins
execute pathogen#infect('plugins-dev/{}', 'plugins-local/{}')

" Generate helptags for manually installed plugins
Helptags

" Use vim-plug for all other plugins
let g:plug_window = 'botright new'
call plug#begin(g:user_config_dir . "/plugins")

" Seamless vim/tmux naviagation
Plug 'christoomey/vim-tmux-navigator'

" Better syntax highlighting, autoindentation, linting, folding, and more for haskell
Plug 'dag/vim2hs'

" Highlight all search results while typing
Plug 'haya14busa/incsearch.vim'

" Improved 'f' motion and much more precise 's' motion
Plug 'justinmk/vim-sneak'

" LaTeX
Plug 'lervag/vim-latex'

" Type inspection and documentation lookup for haskell
Plug 'lukerandall/haskellmode-vim'

" Gruvbox colorscheme
Plug 'morhetz/gruvbox'

" i3 config syntax higlighting
Plug 'PotatoesMaster/i3-vim-syntax'

" Snippets
if has('python') || has('python3')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
endif

" Better lua indentation and syntax highlighting
Plug 'tbastos/vim-lua'

" Causes the default register to be synchronized with the tmux paste buffer when
" text is yanked. (requires vim-tmux-focus-events)
Plug 'roxma/vim-tmux-clipboard'

" Easily comment stuff out
Plug 'tpope/vim-commentary'

" Git integration
Plug 'tpope/vim-fugitive'

" Support for '.' repetition in plugins
Plug 'tpope/vim-repeat'

" Mappings for easily surrounding text with quotes, braces parentheses, etc.
Plug 'tpope/vim-surround'

" Provides many convenient bracket mappings
Plug 'tpope/vim-unimpaired'

" Provides text objects and folding for indented languages
Plug 'tweekmonster/braceless.vim'

" Provides pandoc markdown highlighting
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Linting
if v:version >= 800 || has('nvim')
    Plug 'w0rp/ale'
endif

call plug#end()
