require('lspsaga').init_lsp_saga {
  finder_action_keys = {
    open = '<cr>',
    vsplit = 's',
    split = 'i',
    quit = '<c-c>',
    scroll_down = '<C-d>',
    scroll_up = '<C-u>',
  },
}

vim.cmd [[
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> <C-d> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-u> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

nnoremap <silent> gr :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>lrn :Lspsaga rename<CR>
]]
