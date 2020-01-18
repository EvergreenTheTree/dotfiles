setlocal ts=4 sw=4 sts=4 expandtab

let g:ale_python_pylint_options = "--init-hook='import sys; sys.path.append(\".\")'"

if exists(':BracelessEnable')
    BracelessEnable
endif

call g:Coc_mappings()

let g:ultisnips_python_style = "google"

