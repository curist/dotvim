let g:completion_enable_auto_popup = 0

autocmd BufEnter * lua require'completion'.on_attach()
