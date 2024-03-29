local dot = require('dot.utils')
local hop = require('hop')

hop.setup {
  keys = 'djkalghwoeirutyvmpsf',
  teasing = false,
}

local w = dot.bind

vim.keymap.set('', 's', w(hop.hint_char2))
vim.keymap.set('', 's<cr>', w(hop.hint_lines))
vim.keymap.set('', 'S', w(hop.hint_vertical))
