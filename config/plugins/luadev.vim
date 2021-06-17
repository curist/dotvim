function! s:vim_lua_mappings()
  nmap <silent><buffer> <leader>ls :Luadev<cr>
  nmap <silent><buffer> <leader>ef :luafile %<cr>
  nmap <silent><buffer> <leader>ee <Plug>(Luadev-RunLine)
  vmap <silent><buffer> <leader>ee <Plug>(Luadev-Run)
  nmap <silent><buffer> <leader>ew <Plug>(Luadev-RunWord)
  imap <silent><buffer> <c-x><c-o> <Plug>(Luadev-Complete)
endfunction

augroup VIM_LUA_MAPPING
  autocmd!
  autocmd FileType lua call s:vim_lua_mappings()
augroup END