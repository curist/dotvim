local hop = require('hop')
local hint = require('hop.hint')
local BC = hint.HintDirection.BEFORE_CURSOR
local AC = hint.HintDirection.AFTER_CURSOR

hop.setup {
  keys = 'fjdkslghwoeirutyvmpqa',
}

--- simple wrap function, aka bind
local function w(fn, opts)
  opts = opts or {}
  return function()
    return fn(opts)
  end
end

vim.keymap.set('', 's', w(hop.hint_char2, { direction = AC }))
vim.keymap.set('', 'S', w(hop.hint_char2, { direction = BC }))

vim.keymap.set('', ',ej', w(hop.hint_lines, { direction = AC }))
vim.keymap.set('', ',ek', w(hop.hint_lines, { direction = BC }))
