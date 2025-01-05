return {
  {
    'jaawerth/fennel.vim',
    ft = 'fennel',
  },
  {
    'udayvir-singh/tangerine.nvim',
    ft = 'fennel',
    opts = {},
  },
  'gpanders/nvim-parinfer',
  'julienvincent/nvim-paredit',
  {
    'dundalek/parpar.nvim',
    dependencies = { 'gpanders/nvim-parinfer', 'julienvincent/nvim-paredit' },
    opts = {},
  },
}
