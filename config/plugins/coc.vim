let g:coc_global_extensions = ['coc-marketplace', 'coc-tsserver', 'coc-css', 'coc-vetur']

au FileType typescript,typescriptreact nn <silent> K :call CocActionAsync('doHover')<cr>
au FileType typescript,typescriptreact nmap <silent> gd <Plug>(coc-type-definition)
au FileType typescript,typescriptreact nmap <silent> <c-]> <Plug>(coc-definition)
au FileType typescript,typescriptreact nmap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <c-x><c-o> coc#refresh()

nn <silent> <leader>l :CocListResume<cr>
nn <silent> <leader>L :CocList lists<cr>
