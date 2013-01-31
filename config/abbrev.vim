cabbrev ss syntax sync fromstart
autocmd FileType html,xml,jsp inoremap <expr> / (getline('.')[col('.')-2]=="<")?"/\<Lt>C-X>\<Lt>C-O>":"/"

