return {
  'tpope/vim-surround',
  'cohama/lexima.vim',
  'tpope/vim-repeat',
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { use_default_keymaps = false },
    keys = {
      {
        '<leader>J',
        ':TSJToggle<cr>',
        desc = 'Toggle Split Join',
      },
    },
  },
  {
    'yorickpeterse/nvim-tree-pairs',
    event = 'BufRead',
  },
}
