function! s:add_rule(at, end, filetype, syntax)
  return lexima#add_rule({
  \ 'char': '<CR>',
  \ 'input': '<CR>',
  \ 'input_after': '<CR>' . a:end,
  \ 'at': a:at,
  \ 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1' . a:end,
  \ 'filetype': a:filetype,
  \ 'syntax': a:syntax,
  \ })
endfunction

call <sid>add_rule('\%(^\s*#.*\)\@<!\<\%(function\)\>\%(.*\<end\>\)\@!.*\%#', 'end', 'lua', [])
call <sid>add_rule('\%(^\s*#.*\)\@<!\s*\<\%(do\|then\)\s*\%#', 'end', 'lua', [])
