" use to track the quickfix window
augroup QFixToggle
  autocmd!
  autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
  autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END

" Resize splits when the window is resized {{{2
au VimResized * :wincmd =

" change git status symbol color {{{2
au BufEnter,BufWritePost * call SyncGitStatusSymbolColor()

