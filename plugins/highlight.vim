if exists('g:loaded_highlight')
  finish
endif
let g:loaded_highlight = 1

" Highlighting
function! s:highlighting()
  " just in case..
  if &modifiable != 1
    return "\<cr>"
  endif

  let l:cword = expand('<cword>')
  if strlen(l:cword) > 0
    let @/ = '\<'.l:cword.'\>'
  endif
  return ":silent set hlsearch\<cr>"
endfunction

function! s:highlighting_selected()
  let @/ = substitute(@c, '\n', '\\n', 'g')
endfunction

" map <cr> to do Highlighting only in modifiable buffers
autocmd BufEnter * if &modifiable == 1 && mapcheck("<cr>") == ""|
      \ nn <buffer> <silent> <expr> <CR> <SID>highlighting()|
      \ xn <buffer> <silent> <expr> <CR> '"cy:call <SID>highlighting_selected()<cr>:set hls<cr>'|
      \ endif
