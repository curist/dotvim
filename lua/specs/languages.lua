return {
  {
    'moonbit-community/moonbit.nvim',
    build = ':TSInstall! moonbit',
    ft = 'moonbit',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      treesitter = { enabled = true },
    },
  },
  {
    'curist/tree-sitter-lx',
    ft = 'lx',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function(plugin)
      local plug_dir = plugin.dir .. '/vim'
      vim.opt.rtp:append(plug_dir)
      require('lazy.core.loader').packadd(plug_dir)
    end,
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
}
