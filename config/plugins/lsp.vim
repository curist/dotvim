  autocmd FileType typescript lua require'nvim_lsp'.tsserver.setup{}
  autocmd FileType typescript nn <buffer> <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
  autocmd FileType typescript nn <buffer> <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>

