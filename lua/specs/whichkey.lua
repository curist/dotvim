return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    spec = {
      { '<leader>t', group = 'test', icon = { icon = '󱖫 ', color = 'green' } },
      { '<leader>l', group = 'lsp', icon = { icon = '', color = 'cyan' } },
      { '<leader>w', group = 'windows', proxy = '<c-w>' },
      { '<leader>g', group = 'git' },
      { '<leader>h', group = 'git hunks' },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
