" deconflicting mappings between bufexplorer and surround {{{2
autocmd BufEnter \[BufExplorer\] unmap ds
autocmd BufLeave \[BufExplorer\] nmap ds <Plug>Dsurround

" don't show quickfix in buffers list {{{2
" set number in quickfix list
autocmd BufRead quickfix setlocal nobuflisted number

" unmap NERDTreeMapCWD {{{2
let g:NERDTreeMapCWD = ''

