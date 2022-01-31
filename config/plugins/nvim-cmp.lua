local cmp = require('cmp')
cmp.setup {
  completion = {
    autocomplete = false, -- disable auto-completion.
  },
}

vim.keymap.set('i', '<c-x><c-o>', function()
  cmp.complete({
    config = {
      sources = {
        { name = 'nvim_lsp' }
      },
    },
  })
end)
