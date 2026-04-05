local scripts = require('dot.scripts')

vim.api.nvim_create_user_command('VT', function(opts)
  scripts.openTerm({
    kind = 'split',
    cmd = opts.args,
    use_cwd = opts.bang,
  })
end, {
  nargs = '?',
  bang = true,
})
