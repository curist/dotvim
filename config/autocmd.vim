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

  " CtrlPClearCache
  autocmd ShellCmdPost * :CtrlPClearCache
augroup END

augroup BundleInstallOnBundleFileWritePost
  autocmd!
  " BundleInstall after bundles.vim saved
  autocmd BufWritePost bundles.vim call UpdateBundleInstall()
  function! UpdateBundleInstall()
    so %
    PlugClean
    " PlugUpdate
  endfunction
augroup END

augroup BehaviourAdjustment
  autocmd!
  " deconflicting mappings between bufexplorer and surround
  autocmd BufEnter \[BufExplorer\] unmap ds
  autocmd BufLeave \[BufExplorer\] nmap ds <Plug>Dsurround

  " don't show quickfix in buffers list
  " set number in quickfix list
  autocmd BufRead quickfix setlocal nobuflisted number nornu
  autocmd BufRead location setlocal nobuflisted number nornu

  " NrrwRgn window maximize as default
  autocmd BufEnter * let b:nrrw_aucmd_create = "%wincmd _"
augroup END
