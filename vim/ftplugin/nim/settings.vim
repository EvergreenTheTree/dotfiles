setlocal ts=2 sw=2 sts=2 expandtab

if exists(':BracelessEnable')
    BracelessEnable
endif

let g:ale_fixers["nim"] = ["nimpretty"]

