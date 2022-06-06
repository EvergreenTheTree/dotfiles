setlocal ts=4 sw=4 sts=4 noexpandtab
let b:ale_fix_on_save = 1
let b:ale_fixers = ['gofmt']
let b:ale_linters = ['gofmt', 'golint', 'gopls', 'govet', 'staticcheck']
