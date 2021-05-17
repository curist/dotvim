" use to track the quickfix window
augroup QFixToggle
  autocmd!
  autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
  autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END

augroup MyCommonAutoCmds
  autocmd!
  " Resize splits when the window is resized
  autocmd VimResized * :wincmd =
augroup END

augroup BehaviourAdjustment
  autocmd!

  " don't show quickfix in buffers list
  " set number in quickfix list
  autocmd BufRead quickfix setlocal nobuflisted number nornu
  autocmd BufRead location setlocal nobuflisted number nornu

  " no line numbers for neovim terminal
  autocmd BufEnter term://* start!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

