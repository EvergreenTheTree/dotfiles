setlocal ts=4 sw=4 sts=4 expandtab

call g:Coc_mappings()

" Set colorcolumn and textwidth to recommended size for rust
set colorcolumn=99
set textwidth=99

let b:ale_fix_on_save = 1

if system('cargo check -q') !~# "\v.*error: could not find `Cargo\.toml` in.*"
    let b:ale_linters_ignore = ['rustc']
endif
