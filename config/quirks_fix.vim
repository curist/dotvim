" deconflicting mappings between bufexplorer and surround {{{2
autocmd BufEnter \[BufExplorer\] unmap ds
autocmd BufLeave \[BufExplorer\] nmap ds <Plug>Dsurround

" unmap NERDTreeMapCWD {{{2
let g:NERDTreeMapCWD = ''

" don't show quickfix in buffers list {{{2
" set number in quickfix list
autocmd BufRead quickfix setlocal nobuflisted number

" NrrwRgn window maximize as default
autocmd BufEnter * let b:nrrw_aucmd_create = "%wincmd _"

