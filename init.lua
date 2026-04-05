-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('core')

-- Setup lazy.nvim
require('lazy').setup({
  spec = {
    { import = 'specs' },
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { 'catppuccin', 'sorbet' } },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = { enabled = false },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tohtml',
        'tutor',
      },
    },
  },
})
