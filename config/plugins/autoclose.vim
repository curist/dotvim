let g:AutoClosePreserveDotReg = 0
let g:AutoCloseSelectionWrapPrefix = ""
let g:AutoCloseProtectedRegions = ["Comment", "Character"]

" FileType whitelist to use AutoCloseExpandEnterOn behaviour
autocmd FileType javascript,scss.css,css,go,c,cpp
      \ let b:AutoCloseExpandEnterOn = "{"

autocmd FileType clojure
      \ let b:AutoClosePairs = AutoClose#ParsePairs("() {} [] \"")
