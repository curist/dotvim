if exists('g:loaded_highlight')
  finish
endif
let g:loaded_highlight = 1

" Highlighting
function! s:highlighting()

  let l:cword = expand('<cword>')
  if strlen(l:cword) > 0
    let @/ = '\<'.l:cword.'\>'
  endif
  return "\<cmd>silent set hlsearch\<cr>"
endfunction

function! s:highlighting_selected()
  let @/ = substitute(@c, '\n', '\\n', 'g')
endfunction

" map <cr> to do Highlighting only when <cr> is not mapped
autocmd BufEnter * if mapcheck("<cr>") == ""|
      \ nn <buffer> <silent> <expr> <CR> <SID>highlighting()|
      \ xn <buffer> <silent> <expr> <CR> '"cy<cmd>call <SID>highlighting_selected()<cr><cmd>set hls<cr>'|
      \ endif
