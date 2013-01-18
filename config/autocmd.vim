" use to track the quickfix window
augroup QFixToggle
  autocmd!
  autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
  autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END

" Resize splits when the window is resized
au VimResized * :wincmd =

" CtrlPClearCache
au ShellCmdPost * :CtrlPClearCache

" behaviour adjustments {{{
  " deconflicting mappings between bufexplorer and surround
  autocmd BufEnter \[BufExplorer\] unmap ds
  autocmd BufLeave \[BufExplorer\] nmap ds <Plug>Dsurround

  " don't show quickfix in buffers list
  " set number in quickfix list
  autocmd BufRead quickfix setlocal nobuflisted number

  " NrrwRgn window maximize as default
  autocmd BufEnter * let b:nrrw_aucmd_create = "%wincmd _"
" }}}
