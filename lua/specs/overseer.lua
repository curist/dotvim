vim.api.nvim_create_user_command('OverseerRestartLast', function()
  local overseer = require('overseer')
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify('No tasks found', vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], 'restart')
  end
end, {})

return {
  'stevearc/overseer.nvim',
  opts = {
    templates = { 'builtin', 'bb-edn' },
  },
  keys = {
    { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'OverseerRun' },
    { '<leader>ot', '<cmd>OverseerToggle<cr>', desc = 'OverseerToggle' },
    { '<leader>ol', '<cmd>OverseerRestartLast<cr>', desc = 'OverseerRestartLast' },
  },
}
