let g:coc_global_extensions = ['coc-lists', 'coc-tsserver', 'coc-css']

nn <silent> K :call CocActionAsync('doHover')<cr>
nmap <silent> gd <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <c-]> <Plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <c-x><c-o> coc#refresh()
nmap <silent> <m-p> <Plug>(coc-diagnostic-prev)
nmap <silent> <m-n> <Plug>(coc-diagnostic-next)

nn <silent> <leader>f :CocList files<cr>
nn <silent> <leader>b :CocList buffers<cr>
nn <silent> <leader>m :CocList mru<cr>
nn <silent> <leader>o :CocList --auto-preview outline<cr>
nn <silent> <leader>c :CocList commands<cr>

nn <silent> <leader>l :CocListResume<cr>
nn <silent> <leader>L :CocList lists<cr>

command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>
function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction
" Keymapping for grep word under cursor with interactive mode
nn <silent> <leader>S :CocList grep<cr>
nn <silent> <leader>s :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

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
vn <silent> <leader>s :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nn <silent> <leader>s :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

