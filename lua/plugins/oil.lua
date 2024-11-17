return {
  'stevearc/oil.nvim',
  opts = {},
  keys = {
    {
      '<leader>C', ':cd ~/.config/nvim<cr>:Oil .<cr>',
      silent = true,
      desc = 'Edit neovim config files',
    },
    {
      '<leader>e', ':Oil<cr>',
      silent = true,
      desc = 'Oil at current file',
    },
    {
      '<leader>E', ':Oil .<cr>',
      silent = true,
      desc = 'Oil at current cwd',
    },
  },
}
