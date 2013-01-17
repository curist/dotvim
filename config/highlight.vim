" sync git status symbol color
hi User1 ctermfg=232 ctermbg=white cterm=reverse

" Highlight problematic whitespace (spaces before tabs)
hi ProblematicSpaces ctermfg=214 ctermbg=160 cterm=bold
match ProblematicSpaces / \+\ze\t/
