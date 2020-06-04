nn <silent> <leader>nt :Fern . -drawer -keep -toggle<CR>
nn <silent> <leader>nf :Fern . -drawer -keep -reveal=%<cr>

function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  set relativenumber!
  set signcolumn=no
endfunction

autocmd FileType fern call s:init_fern()
