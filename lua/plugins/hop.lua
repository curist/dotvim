return {
  'hadronized/hop.nvim',
  opts = {
    keys = 'djkalghwoeirutyvmpsf',
    teasing = false,
  },
  keys = function()
    local w = require('dot.utils').bind
    local hop = require'hop'
    return {
      {'s', mode = {'n', 'v'}, w(hop.hint_char2)},
      {'s<cr>', mode = {'n', 'v'}, w(hop.hint_lines)},
      {'S', mode = {'n', 'v'}, w(hop.hint_vertical)},
    }
  end,
}
