return {
  'mrjones2014/smart-splits.nvim',
  opts = {
    at_edge = 'stop',
  },
  keys = function()
    local ss = require('smart-splits')
    local si = function(f)
      return function()
        vim.cmd 'stopinsert'
        f()
      end
    end
    return {
      {
        "<m-h>",
        si(ss.move_cursor_left),
        mode = { 'n', 'i' },
        desc = "Move cursor to left pane",
      },
      {
        "<m-j>",
        si(ss.move_cursor_down),
        mode = { 'n', 'i' },
        desc = "Move cursor to bottom pane",
      },
      {
        "<m-k>",
        si(ss.move_cursor_up),
        mode = { 'n', 'i' },
        desc = "Move cursor to up pane",
      },
      {
        "<m-l>",
        si(ss.move_cursor_right),
        mode = { 'n', 'i' },
        desc = "Move cursor to right pane",
      },
      {
        "<m-H>",
        ss.resize_left,
        desc = "Increase pane size to left",
      },
      {
        "<m-J>",
        ss.resize_down,
        desc = "Increase pane size to bottom",
      },
      {
        "<m-K>",
        ss.resize_up,
        desc = "Increase pane size to up",
      },
      {
        "<m-L>",
        ss.resize_right,
        desc = "Increase pane size to right",
      },
    }
  end,
}
