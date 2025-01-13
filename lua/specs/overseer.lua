return {
  'stevearc/overseer.nvim',
  opts = {
    templates = { 'builtin', 'bb-edn' },
  },
  keys = {
    { '<leader>or', '<cmd>OverseerRun<cr>' },
    { '<leader>ot', '<cmd>OverseerToggle<cr>' },
  },
}
