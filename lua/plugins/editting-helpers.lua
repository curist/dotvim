return {
  'tpope/vim-surround',
  'cohama/lexima.vim',
  'tpope/vim-repeat',
  {
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
  },
  {
    'andymass/vim-matchup',
    event = "BufRead",
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  }
}
