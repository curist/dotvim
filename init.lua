-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.cmd('runtime! config/*.{vim,lua}')

-- Add luarocks to rtp
local home = vim.uv.os_homedir()
package.path = package.path .. ';' .. home .. '/.luarocks/share/lua/5.1/?/init.lua;'
package.path = package.path .. ';' .. home .. '/.luarocks/share/lua/5.1/?.lua;'
package.cpath = package.cpath .. ';' .. home .. '/.luarocks/lib/lua/5.1/?.so'

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
