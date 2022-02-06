local dot = require('dot.utils')
local scripts = require('dot.scripts')

vim.keymap.set('n', '<m-t>', scripts.openTerm)
vim.keymap.set('n', '<m-T>', dot.bind(scripts.openTerm, { use_cwd = true }))
vim.cmd [[
  command! VT lua require('dot.scripts').openTerm({ kind = 'split' })
]]

