return {
  'hadronized/hop.nvim',
  opts = {
    keys = 'djkalghwoeirutyvmpsf',
    teasing = false,
  },
  keys = {
    {
      "s",
      mode = { "n", "v" },
      function()
        local hop = require("hop")
        hop.hint_char2()
      end,
    },
    {
      "s<cr>",
      mode = { "n", "v" },
      function()
        local hop = require("hop")
        hop.hint_lines()
      end,
    },
    {
      "S",
      mode = { "n", "v" },
      function()
        local hop = require("hop")
        hop.hint_vertical()
      end,
    },
  },
}
