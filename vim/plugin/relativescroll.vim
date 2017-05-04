if exists('g:loaded_relativescroll')
    finish
endif
let g:loaded_relativescroll = 1

noremap <silent> <c-e> @=1."\<lt>C-D>"<cr>:set scroll=0<cr>
noremap <silent> <c-y> @=1."\<lt>C-U>"<cr>:set scroll=0<cr>
noremap <silent> <c-d> @=winheight(0)/2."\<lt>C-D>"<cr>:set scroll=0<cr>
noremap <silent> <c-u> @=winheight(0)/2."\<lt>C-U>"<cr>:set scroll=0<cr>
