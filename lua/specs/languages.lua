local dot_cfg = require('dot.config')

vim.lsp.config('lx', {
  cmd = { 'lx', 'lsp' },
  filetypes = { 'lx' },
  root_markers = { '.lxroot', '.git' },
  single_file_support = true,
})
vim.lsp.enable('lx')

vim.lsp.config('twinkle', {
  cmd = { dot_cfg.paths.twinkle_lsp, 'lsp' },
  filetypes = { 'twinkle' },
  root_markers = { 'twinkle.toml', '.git' },
  single_file_support = true,
})
vim.lsp.enable('twinkle')

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
