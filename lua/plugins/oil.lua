return {
  'stevearc/oil.nvim',
  cmd = 'Oil',
  opts = {},
  keys = {
    {
      '<leader>C', ':cd ~/.config/nvim<cr>:Oil .<cr>',
      silent = true,
      desc = 'Edit neovim config files',
    },
    {
      '<leader>o', ':Oil<cr>',
      silent = true,
      desc = 'Oil at current file',
    },
    {
      '<leader>O', ':Oil .<cr>',
      silent = true,
      desc = 'Oil at current cwd',
    },
  },
}
