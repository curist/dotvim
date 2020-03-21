autocmd FileType typescript inoremap <silent><expr> <c-x><c-o> coc#refresh()
autocmd FileType typescript nn <buffer><silent> K :call CocActionAsync('doHover')<cr>
autocmd FileType typescript nn <silent> gd <Plug>(coc-definition)
autocmd FileType typescript nn <silent> <c-]> <Plug>(coc-definition)
autocmd FileType typescript nmap <leader>rn <Plug>(coc-rename)

autocmd FileType typescript nmap <silent> [g <Plug>(coc-diagnostic-prev)
autocmd FileType typescript nmap <silent> ]g <Plug>(coc-diagnostic-next)
