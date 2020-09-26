let g:coc_global_extensions = ['coc-lists', 'coc-tsserver', 'coc-css', 'coc-vetur']

au FileType typescript,typescriptreact,vue nn <silent> K :call CocActionAsync('doHover')<cr>
au FileType typescript,typescriptreact,vue nmap <silent> gd <Plug>(coc-type-definition)
au FileType typescript,typescriptreact,vue nmap <silent> <c-]> <Plug>(coc-definition)
au FileType typescript,typescriptreact,vue nmap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <c-x><c-o> coc#refresh()

nn <silent> <leader>f :CocList files<cr>
nn <silent> <leader>m :CocList mru<cr>
nn <silent> <leader>b :CocList buffers<cr>
nn <silent> <Leader>s :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
vn <silent> <leader>s :<c-u>call <SID>GrepFromSelected(visualmode())<cr>
nn <silent> <leader>S :CocList grep<cr>

nn <silent> <m-n> :CocNext<cr>
nn <silent> <m-p> :CocPrev<cr>
nn <silent> <leader>l :CocListResume<cr>
nn <silent> <leader>L :CocList lists<cr>


function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction
