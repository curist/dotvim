let g:AutoClosePreserveDotReg = 0
let g:AutoCloseSelectionWrapPrefix = ""
let g:AutoCloseProtectedRegions = ["Comment", "Character"]

" FileType whitelist to use AutoCloseExpandEnterOn behaviour
autocmd FileType javascript,scss,css,go,c,cpp,rust
      \ let b:AutoCloseExpandEnterOn = "{"

autocmd FileType clojure,scheme
      \ let b:AutoClosePairs = AutoClose#ParsePairs("() {} [] \"")
