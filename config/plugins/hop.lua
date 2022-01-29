local hop = require('hop')
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

vim.keymap.set('', 's', w(hop.hint_char2, { direction = require'hop.hint'.HintDirection.AFTER_CURSOR }))
vim.keymap.set('', 'S', w(hop.hint_char2, { direction = require'hop.hint'.HintDirection.BEFORE_CURSOR }))

vim.keymap.set('', ',ej', w(hop.hint_lines, { direction = require'hop.hint'.HintDirection.AFTER_CURSOR }))
vim.keymap.set('', ',ek', w(hop.hint_lines, { direction = require'hop.hint'.HintDirection.BEFORE_CURSOR }))
