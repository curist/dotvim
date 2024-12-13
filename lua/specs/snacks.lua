return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    indent = {
      enabled = true,
      chunk = { enabled = true },
    },
    scope = { enabled = true },
    scroll = {
      enabled = true,
      animate = { duration = { step = 5, total = 80 } },
    },
  },
}
