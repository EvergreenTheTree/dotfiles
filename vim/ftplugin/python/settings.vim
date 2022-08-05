setlocal ts=4 sw=4 sts=4 expandtab

let g:ale_python_pylint_options = "-m pylint --init-hook='import sys; sys.path.append(\".\")'"
let g:ale_python_pylint_executable = "python3"
let b:ale_fixers = ['black']

if exists(':BracelessEnable')
    BracelessEnable
endif

let g:ultisnips_python_style = "google"

