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

function! s:customize_vaffle_mappings() abort
  nmap <silent> <buffer> C :call vaffle#chdir_here()<cr>:pwd<cr>
endfunction

augroup vimrc_vaffle
  autocmd!
  autocmd FileType vaffle call s:customize_vaffle_mappings()
augroup END
