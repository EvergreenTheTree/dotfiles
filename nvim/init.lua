vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/py3nvim/bin/python")

-- if not package.loaded["lazy"] then
--    vim.cmd("packadd lush.nvim")
-- end

-- Plugins {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- TODO: Migrate plugin configurations/keybindings to their own files
-- TODO: Neogit
require("lazy").setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false
    },
    {
        "tpope/vim-commentary",
        cond = function() return not vim.g.vscode end
    },
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",
    "andymass/vim-matchup",
    "tpope/vim-repeat",
    "justinmk/vim-sneak",
    "justinmk/vim-dirvish",
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "tpope/vim-obsession",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
    "stevearc/conform.nvim",
    "stevearc/aerial.nvim",
    "mfussenegger/nvim-lint",
    "hrsh7th/nvim-cmp",     -- Autocompletion plugin
    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "aserowy/tmux.nvim",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    "mbbill/undotree",
})

require("mason").setup()
require("mason-lspconfig").setup()

-- Setup language servers.
local lspconfig = require("lspconfig")
-- TODO: look into https://github.com/mrcjkb/rustaceanvim if I do more rust
lspconfig.rust_analyzer.setup {
    -- Server-specific settings. See `:help lspconfig-setup`
    settings = {
        ["rust-analyzer"] = {},
    },
}
lspconfig.lua_ls.setup {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
            return
        end
    end,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            },
            diagnostics = {
                globals = {
                    "vim",
                    "require",
                },
            },
        }
    }
}
lspconfig.clangd.setup{}

lspconfig.basedpyright.setup{
    settings = {
        python = {
            analysis = {
                ignore = { "*" }, -- using ruff
            }
        },
        basedpypyright = {
            disableOrganizeImports = true, -- using ruff
            capabilities = {
                textDocument = {
                    publishDiagnostics = {
                        tagSupport = {
                            valueSet = { 2 },
                        },
                    },
                },
            },
        },
    }
}

lspconfig.ruff.setup{}

require "init.diagnostic_delay"
vim.diagnostic.config({
    virtual_text = true,
})
-- Populate loclist with the current buffer diagnostics
-- vim.api.nvim_create_autocmd("DiagnosticChanged", {
--   callback = function(args)
--     vim.diagnostic.setloclist({open = false})
--   end,
-- })

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
--vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
--vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        --vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>=", function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

-- nvim-cmp setup
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require "cmp"
cmp.setup {
    completion = {
        keyword_length = 0,
        autocomplete = false,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
        ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if not cmp.select_next_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end,

        ['<S-Tab>'] = function(fallback)
            if not cmp.select_prev_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end,
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'nvim_lua' },
    },
}

local tmux = require("tmux")

tmux.setup({
    copy_sync = {
        -- enables copy sync. by default, all registers are synchronized.
        -- to control which registers are synced, see the `sync_*` options.
        enable = true,

        -- ignore specific tmux buffers e.g. buffer0 = true to ignore the
        -- first buffer or named_buffer_name = true to ignore a named tmux
        -- buffer with name named_buffer_name :)
        ignore_buffers = { empty = false },

        -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
        -- clipboard by tmux
        redirect_to_clipboard = false,

        -- offset controls where register sync starts
        -- e.g. offset 2 lets registers 0 and 1 untouched
        register_offset = 0,

        -- overwrites vim.g.clipboard to redirect * and + to the system
        -- clipboard using tmux. If you sync your system clipboard without tmux,
        -- disable this option!
        sync_clipboard = true,

        -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
        sync_registers = true,

        -- syncs deletes with tmux clipboard as well, it is adviced to
        -- do so. Nvim does not allow syncing registers 0 and 1 without
        -- overwriting the unnamed register. Thus, ddp would not be possible.
        sync_deletes = true,

        -- syncs the unnamed register with the first buffer entry from tmux.
        sync_unnamed = true,
    },
    navigation = {
        -- cycles to opposite pane while navigating into the border
        cycle_navigation = true,

        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true,

        -- prevents unzoom tmux when navigating beyond vim border
        persist_zoom = false,
    },
    resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = false,
    }
})


local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
telescope.load_extension("aerial")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, {})
vim.keymap.set("n", "<leader>fs", telescope.extensions.aerial.aerial, {})
vim.keymap.set("n", "<leader>fl", telescope_builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", {})

vim.g.dirvish_mode = [[sort ir /[^\/]$/ | silent! keeppatterns /^.*[^\/]$/,$ sort i | nohl | 1]]
vim.g.dirvish_relative_paths = 1
function Dirvish_settings()
    vim.keymap.set("n", "gh", function ()
        vim.b.hidden = not vim.b.hidden
        if vim.b.hidden then
            vim.cmd([[silent keeppatterns g@\v^\.[^\/]+/?$@d _]])
        else
            vim.cmd("Dirvish")
        end
    end,
    { buffer = true, silent = true }
    )
end
vim.api.nvim_create_autocmd("FileType", {
    pattern = "dirvish",
    callback = Dirvish_settings
})

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "rust", "python", "markdown", "markdown_inline" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    -- auto_install = vim.fn.executable("tree-sitter") == 1,
    auto_install = false,

    -- List of parsers to ignore installing (or "all")
    ignore_install = {},

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local disabled_langs = { vim = true, vimdoc = true }
            if disabled_langs[lang] then return true end
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },

    textobjects = {
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
    indent = {
        enable = true,
    },
}

require("lint").linters_by_ft = {
    bash = {"shellcheck"},
    sh = {"shellcheck"},
}
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    callback = function () require("lint").try_lint() end,
})

require("aerial").setup()

require("gitsigns").setup{
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>hd', gitsigns.diffthis)
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        --map('n', '<leader>td', gitsigns.toggle_deleted)

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}

-- }}}
-- Colorscheme {{{

require("catppuccin").setup({
    flavour = "mocha",
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = {},
        conditionals = {},
    },
    custom_highlights = function(colors)
        return {
            StatusLine = { bg = colors.surface0 },
            TabLine = { fg = colors.subtext0, bg = colors.surface0 },
            TabLineFill = { bg = colors.surface0 },
            TabLineSel = { fg = colors.rosewater, bg = colors.base },
            Pmenu = { fg = colors.text },
            Comment = { fg = colors.overlay1 },
            LineNr = { fg = colors.overlay1 },
            NormalFloat = { bg = colors.surface0 },
        }
    end,
    color_overrides = {
        mocha = {
            base = "#181825",
        }
    }
})
vim.cmd.colorscheme "catppuccin"

-- }}}
-- Options {{{

vim.opt.colorcolumn = { 80 }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.foldcolumn = "2"
vim.opt.foldlevel = 99
vim.opt.helpheight = 0
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars = "tab:> ,extends:>,precedes:<,nbsp:-,trail:-"
vim.opt.number = true
vim.opt.path = ".,**"
vim.opt.scrolloff = 3
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.sidescrolloff = 3
vim.opt.smartcase = true
vim.opt.undofile = true

vim.g.markdown_folding = 1
vim.g.matchup_matchparen_offscreen = {method = "popup"}

-- }}}
-- Mappings {{{

vim.keymap.set("n", "<leader><leader>", "<c-l><cmd>nohlsearch<cr>")
if vim.fn.has("win32") == 1 then
    vim.keymap.set("n", "<leader>e", "<cmd>edit ~\\AppData\\Local\\nvim\\init.lua<cr>")
else
    vim.keymap.set("n", "<leader>e", "<cmd>edit ~/.config/nvim/init.lua<cr>")
end

function Docgen()
    -- Generate help files
    for _, docdir in ipairs(vim.fn.globpath(vim.opt.packpath._value, "**/doc", true, true)) do
        pcall(vim.cmd.helptags, docdir)
    end
end

vim.keymap.set("n", "<leader>d", Docgen)

-- vim.keymap.set("n", "<c-h>", "<c-w>h")
-- vim.keymap.set("n", "<c-j>", "<c-w>j")
-- vim.keymap.set("n", "<c-k>", "<c-w>k")
-- vim.keymap.set("n", "<c-l>", "<c-w>l")

if vim.g.vscode then
    vim.keymap.set("x", "gc", "<Plug>VCodeCommentary")
    vim.keymap.set("n", "gc", "<Plug>VCodeCommentary")
    vim.keymap.set("o", "gc", "<Plug>VCodeCommentary")
    vim.keymap.set("n", "gcc", "<Plug>VCodeCommentaryLine")
end

vim.keymap.set("n", "f", "<Plug>Sneak_f")
vim.keymap.set("n", "F", "<Plug>Sneak_F")
vim.keymap.set("n", "t", "<Plug>Sneak_t")
vim.keymap.set("n", "T", "<Plug>Sneak_T")

vim.keymap.set("n", "<leader>w", "<cmd>Obsession<cr>")

-- }}}
-- Status Line {{{

function Statusline()
    local sl = ""
    local filename = vim.fn.expand("%")
    local squeeze_width = vim.fn.winwidth(0) - (filename:len() / 2)

    -- Buffer number
    sl = sl .. "[%-3.3n] "
    -- File name
    if squeeze_width > 50 then
        sl = sl .. "%f "
    end
    -- Window flags
    sl = sl .. "%h%w%q"
    if squeeze_width > 50 then
        -- Readonly flag
        sl = sl .. "%r"
    end
    -- Modified flag
    sl = sl .. "%m"
    -- Switch to right side
    sl = sl .. "%="
    if squeeze_width > 50 then
        sl = sl .. "["
        -- File encoding
        if vim.o.fenc:len() > 0 then
            sl = sl .. vim.o.fenc
        else
            sl = sl .. "none"
        end
        -- File format
        sl = sl .. "," .. vim.o.ff .. "]"
    end
    -- Filetype
    sl = sl .. "%y "
    -- Cursor line and total lines
    sl = sl .. "%l/%L"
    -- Cursor column
    sl = sl .. "-%v "
    -- Percentage through file
    sl = sl .. "%P"

    return sl
end

-- Statusline
vim.o.statusline = '%!luaeval("Statusline()")'

-- }}}

-- vim:fdm=marker sw=4 sts=4 ts=4 et
