cabbrev <silent> ss syntax sync fromstart
cabbrev <silent> w!! silent exe "write !sudo tee % >/dev/null"
autocmd FileType html,xml,jsp inoremap <expr> / (getline('.')[col('.')-2]=="<")?"/\<Lt>C-X>\<Lt>C-O>":"/"

