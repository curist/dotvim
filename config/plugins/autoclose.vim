let g:AutoClosePreserveDotReg = 0
let g:AutoCloseSelectionWrapPrefix = ""
let g:AutoCloseProtectedRegions = ["Comment", "Character"]

" FileType whitelist to use AutoCloseExpandEnterOn behaviour
autocmd FileType javascript :let b:AutoCloseExpandEnterOn = "{"

