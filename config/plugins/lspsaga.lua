require('lspsaga').init_lsp_saga {
  finder_action_keys = {
    open = '<cr>',
    vsplit = 's',
    split = 'i',
    quit = '<c-c>',
    scroll_down = '<C-d>',
    scroll_up = '<C-u>',
  },
  code_action_keys = {
    quit = '<c-c>',
  },
}

vim.cmd [[
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> <C-d> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-u> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> <C-p> :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>

nnoremap <silent> gr :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>lrn :Lspsaga rename<CR>
nnoremap <silent><leader>ld :Lspsaga show_line_diagnostics<CR>
nnoremap <silent><leader>la <cmd>lua require('lspsaga.codeaction').code_action()<CR>
]]
