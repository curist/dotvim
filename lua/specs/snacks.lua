return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = {
      enabled = true,
      left = { 'sign', 'mark' },
      right = { 'git' },
    },
    scroll = {
      enabled = true,
      animate = { duration = { step = 5, total = 80 } },
    },
  },
}
