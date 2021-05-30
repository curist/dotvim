" use to track the quickfix window
augroup QFixToggle
  autocmd!
  autocmd BufWinEnter quickfix lua require('dot.qf').set_list()
augroup END

augroup BehaviourAdjustment
  autocmd!
  " Resize splits when the window is resized
  autocmd VimResized * wincmd =

  " don't show quickfix in buffers list
  " set number in quickfix list
  autocmd BufRead quickfix setlocal nobuflisted number nornu
  autocmd BufRead location setlocal nobuflisted number nornu

  " no line numbers for neovim terminal
  autocmd BufEnter term://* start!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

