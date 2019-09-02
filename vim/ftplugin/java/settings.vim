set makeprg=javac\ %
set ts=4 sw=4 sts=4 expandtab

nnoremap <silent> <buffer> K :call LanguageClient_textDocument_hover()<cr>
nnoremap <silent> <buffer> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> <buffer> <f2> :call LanguageClient_textDocument_rename()<cr>
