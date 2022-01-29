local cmp = require('cmp')
cmp.setup {
  completion = {
    autocomplete = false, -- disable auto-completion.
  },
}

_G.vimrc = _G.vimrc or {}
_G.vimrc.cmp = _G.vimrc.cmp or {}
_G.vimrc.cmp.lsp = function()
  cmp.complete({
    config = {
      sources = {
        { name = 'nvim_lsp' }
      }
    }
  })
end

vim.cmd([[
  inoremap <C-x><C-o> <Cmd>lua vimrc.cmp.lsp()<CR>
]])
