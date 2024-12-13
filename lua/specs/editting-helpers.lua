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
    event = 'BufRead',
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },
  {
    'aaronik/treewalker.nvim',
    keys = {
      {
        '<c-j>',
        ':Treewalker Down<cr>',
        desc = 'Treewalker Down',
        silent = true,
      },
      {
        '<c-k>',
        ':Treewalker Up<cr>',
        desc = 'Treewalker Up',
        silent = true,
      },
      {
        '<c-h>',
        ':Treewalker Left<cr>',
        desc = 'Treewalker Left',
        silent = true,
      },
      {
        '<c-l>',
        ':Treewalker Right<cr>',
        desc = 'Treewalker Right',
        silent = true,
      },
    },
  },
}
