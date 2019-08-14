let b:detectindent_preferred_expandtab = 1
let b:detectindent_preferred_indent = 4

let g:ale_python_pylint_options = "--init-hook='import sys; sys.path.append(\".\")'"
let b:ale_fixers = ["black", "remove_trailing_lines", "trim_whitespace", "isort"]

if exists(':BracelessEnable')
    BracelessEnable
endif

let g:ultisnips_python_style = "google"

