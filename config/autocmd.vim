" use to track the quickfix window
augroup QFixToggle
  autocmd!
  autocmd BufWinEnter quickfix silent! lua require('dot.qf').set_list()
augroup END

augroup BehaviourAdjustment
  autocmd!
  " Resize splits when the window is resized
  " autocmd VimResized * wincmd =

  " don't show quickfix in buffers list
  " set number in quickfix list
  autocmd BufRead quickfix setlocal nobuflisted number nornu
  autocmd BufRead location setlocal nobuflisted number nornu

  " no line numbers for neovim terminal
  " autocmd BufEnter term://* start!
  autocmd TermOpen * setlocal nonumber norelativenumber

  autocmd FileType qf 8wincmd_
augroup END

" highlights yanked text
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

let &titlestring=getcwd()
augroup dirchange
  autocmd!
  autocmd DirChanged * let &titlestring=v:event['cwd']
augroup END
