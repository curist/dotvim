let $FZF_DEFAULT_COMMAND = 'ag -g ""'

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler
      \| autocmd BufLeave <buffer> set laststatus=2 ruler
