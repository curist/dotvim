" git status symbol
function! GitStatusSymbol()
  if !exists('b:git_dir')
    return ''
  endif
  return '⚡'
endfunction

" sync git status symbol color
function! SyncGitStatusSymbolColor()
  if !exists('b:git_dir')
    return
  endif
  let git_dir_is_dirty = system("git status -s --ignore-submodules=dirty")
  if git_dir_is_dirty != ''
    hi User1 ctermfg=232 ctermbg=red cterm=reverse,bold
  else
    hi User1 ctermfg=232 ctermbg=white cterm=reverse
  endif
endfunction

" Highlighting
function! Highlighting()
  " just in case..
  if &modifiable != 1
    return "\<cr>"
  endif

  " check if the current word is meaningful
  if expand('<cword>') =~ '^[a-zA-Z][a-zA-Z#_0-9]*$'
    let @/ = '\<'.expand('<cword>').'\>'
  endif
  return ":silent set hlsearch\<cr>:ShowSearchIndex\<cr>"
endfunction

" toggles the quickfix window.
command -bang -nargs=0 QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
  else
    copen 10
  endif
endfunction

" remove trailing spaces
function! KillTrailingSpaces()
  let l:save_cursor = getpos('.')
  :%s/\s\+$//e
  :call cursor(l:save_cursor[1], l:save_cursor[2], l:save_cursor[3])
endfunction

" add REMARK to sql statements
function! SqlRemarkWrapping()
  execute "norm ggOREMARK BEGIN"
  execute "norm Gk"
  if search(';', 'nW') == 0
    execute "norm Go;"
  endif
  execute "norm GoREMARK END"
endfunction

" git diff close
function! MyCloseDiff()
  if (&diff == 0 || getbufvar('#', '&diff') == 0)
        \ && (bufname('%') !~ '^fugitive:' && bufname('#') !~ '^fugitive:')
    echom "Not in diff view."
    return
  endif

  " close current buffer if alternate is not fugitive but current one is
  if bufname('#') !~ '^fugitive:' && bufname('%') =~ '^fugitive:'
    if bufwinnr("#") == -1
      b #
      bd #
    else
      bd
    endif
  else
    bd #
  endif
endfunction
