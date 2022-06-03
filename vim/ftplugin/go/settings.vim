setlocal ts=4 sw=4 sts=4 noexpandtab
if has('nvim')
    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
endif
