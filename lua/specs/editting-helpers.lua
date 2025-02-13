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
        '<leader>j',
        ':TSJToggle<cr>',
        desc = 'Toggle Split Join',
      },
    },
  },
  {
    'andymass/vim-matchup',
    event = 'BufRead',
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },
}
