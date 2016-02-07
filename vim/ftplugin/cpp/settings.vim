" Compile C++ files using :make, even when there is no makefile
if glob('[Mm]akefile') == "" 
    let &mp="g++ -o %< %"
endif
