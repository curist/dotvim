return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    {
      '<leader>j',
      ':TSJToggle<cr>',
      desc = 'Toggle Split Join',
    },
  },
  opts = { use_default_keymaps = false },
}
