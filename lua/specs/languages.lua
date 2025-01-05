return {
  {
    'curist/tree-sitter-lx',
    ft = 'lx',
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
