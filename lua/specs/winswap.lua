return {
  dir = vim.fn.stdpath('config') .. '/lua/plugins/winswap',
  name = 'winswap',
  config = function()
    vim.api.nvim_set_hl(0, 'WinSwapLabel', {
      bg = '#f5a623',
      fg = '#1a1a1a',
      bold = true,
    })
    require('winswap').setup({})
  end,
  keys = {
    {
      '<leader>wS',
      function() require('winswap').swap({ follow = true }) end,
      desc = 'Swap windows',
    },
  },
}
