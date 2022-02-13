local dot = require('dot.utils')
local scripts = require('dot.scripts')

vim.keymap.set('n', '<m-t>', scripts.openTerm)
vim.keymap.set('n', '<m-T>', dot.bind(scripts.openTerm, { use_cwd = true }))
vim.api.nvim_add_user_command('VT', function(opts)
  local cmd = opts.args
  local use_cwd = opts.bang
  scripts.openTerm({
    kind = 'split',
    cmd = cmd,
    use_cwd = use_cwd,
  })
end, {
  nargs = '?',
  bang = true,
})
