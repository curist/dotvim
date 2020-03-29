let g:coc_global_extensions = ['coc-tsserver', 'coc-css']

au FileType typescript,typescriptreact nn <silent> <buffer> K :call CocActionAsync('doHover')<cr>
au FileType typescript,typescriptreact nmap <silent> <buffer> gd <Plug>(coc-type-definition)
au FileType typescript,typescriptreact nmap <silent> <buffer> gr <Plug>(coc-references)
au FileType typescript,typescriptreact nmap <silent> <buffer> <c-]> <Plug>(coc-definition)
au FileType typescript,typescriptreact nmap <buffer> <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <c-x><c-o> coc#refresh()
