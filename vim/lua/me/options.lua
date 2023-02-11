-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
	extensions = {
		fzf = {
			fuzzy = true,					 -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,	 -- override the file sorter
			case_mode = "smart_case",		 -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		}
	}
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>H', builtin.help_tags, {})

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
				-- elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
				--	  vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
				else
					fallback()
				end
			end,
			-- s = function(fallback)
			--	   if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
			--		   vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
			--	   else
			--		   fallback()
			--	   end
			-- end
		}),
		["<S-Tab>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				-- elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
				--	  return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
				else
					fallback()
				end
			end,
			-- s = function(fallback)
			--	   if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
			--		   return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
			--	   else
			--		   fallback()
			--	   end
			-- end
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

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local bufopts = { noremap=true, silent=true, buffer=bufnr }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.keymap.set('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	-- vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- vim.keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- vim.keymap.set('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.keymap.set('n', ',D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.keymap.set('n', '<f2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.keymap.set('n', ',ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	-- vim.keymap.set('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	vim.keymap.set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	vim.keymap.set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	-- vim.keymap.set('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
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
require'clangd_extensions'.setup{
	server = { on_attach = on_attach }
}

require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = {
		"arduino",
		"bash",
		"c",
		"cpp",
		"go",
		"haskell",
		"help",
		"html",
		"java",
		"javascript",
		"json",
		"latex",
		"lua",
		"make",
		"meson",
		"racket",
		"rust",
		"scss",
		"vim",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = false,

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 15 * 1024 * 1024 -- 15 mb
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
			disable_fts = { vim=true, python=true, markdown=true, pandoc=true}
			if disable_fts[vim.bo.filetype] then
				return true
			end
		end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				-- You can optionally set descriptions to the mappings (used in the desc parameter of
				-- nvim_buf_set_keymap) which plugins like which-key display
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
			},
			-- You can choose the select mode (default is charwise 'v')
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * method: eg 'v' or 'o'
			-- and should return the mode ('v', 'V', or '<c-v>') or a table
			-- mapping query_strings to modes.
			selection_modes = {
				['@parameter.outer'] = 'v', -- charwise
				['@function.outer'] = 'V', -- linewise
				['@class.outer'] = '<c-v>', -- blockwise
			},
			-- If you set this to `true` (default is `false`) then any textobject is
			-- extended to include preceding or succeeding whitespace. Succeeding
			-- whitespace has priority in order to act similarly to eg the built-in
			-- `ap`.
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * selection_mode: eg 'v'
			-- and should return true of false
			include_surrounding_whitespace = true,
		},

		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]]"] = "@function.outer",
				-- ["]]"] = { query = "@class.outer", desc = "Next class start" },

				-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
				-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
				["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[["] = "@function.outer",
				-- ["[["] = "@class.outer",

				["[s"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
				["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" },
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
			-- Below will go to either the start or the end, whichever is closer.
			-- Use if you want more granular movements
			-- Make it even more gradual by adding multiple queries and regex.
			goto_next = {
				["]d"] = "@conditional.outer",
			},
			goto_previous = {
				["[d"] = "@conditional.outer",
			}
		},
	},
}

require'treesitter-context'.setup{
	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
	trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	min_window_height = 5, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
}

vim.api.nvim_set_hl(0, "@field", { link = "Normal" })
vim.api.nvim_set_hl(0, "@variable", { link = "Normal" })
vim.api.nvim_set_hl(0, "@parameter", { link = "Normal" })
