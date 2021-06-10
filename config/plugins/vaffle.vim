let g:vaffle_show_hidden_files = 1
let g:vaffle_force_delete = 1

nnoremap <silent> <leader>v :Vaffle<cr>

function! SmartVaffle()
  if @% == ""
    Vaffle %:p:h
  else
    Vaffle %
  endif
endfun
nnoremap <silent> <leader>V :call SmartVaffle()<cr>

