" Vim has a compiler file for javac
compiler javac

command! -buffer Make silent make! % | silent redraw!

" Key shortcut to automatically insert a class and main method
nnoremap <localleader>c 0ipublic class <C-r>=expand("%:t:r")<Cr> {<Cr>public static void main(String[] args) {<Cr><Cr>}<Cr>}<Cr><Esc>3k

" Javacomplete
setlocal omnifunc=javacomplete#Complete
