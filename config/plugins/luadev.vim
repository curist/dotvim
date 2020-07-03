augroup LuaDev
  autocmd!
  autocmd FileType lua nmap ,r <Plug>(Luadev-RunLine)
  autocmd FileType lua vmap ,r <Plug>(Luadev-Run)
  autocmd FileType lua imap <c-x><c-o> <Plug>(Luadev-Complete)
augroup END
