local scripts = require('dot.scripts')
local gitsigns = require('gitsigns')

vim.keymap.set('n', '<leader>gg', function()
  scripts.openTerm({ cmd = 'lazygit', nowait = true })
end, { desc = 'Lazygit' })

vim.keymap.set('n', '<leader>gq', function()
  gitsigns.setqflist('all')
end, { desc = 'Send git hunks to qflist' })

vim.keymap.set('n', '<leader>gb', function()
  gitsigns.blame_line{full=true}
end, { desc = 'Git blame current line' })

vim.keymap.set('n', '<leader>gB', gitsigns.blame, { desc = 'Git blame current file' })

vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { silent = true })

