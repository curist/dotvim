return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
    keys = function()
      local w = require('dot.utils').bind
      local scripts = require('dot.scripts')
      local gitsigns = require'gitsigns'
      return {
        {
          '<leader>gg',
          w(scripts.openTerm, { cmd = 'lazygit', nowait = true }),
        },
        {
          '<leader>gq',
          w(gitsigns.setqflist, 'all'),
          desc = 'Send git hunks to qflist',
        },
        {
          '<leader>gb',
          w(gitsigns.blame_line, {full=true}),
          desc = 'Git blame current line',
        },
        {
          '<leader>gB',
          gitsigns.blame,
          desc = 'Git blame current file',
        },
        {
          'ih',
          mode = {'o', 'x'},
          ':<C-U>Gitsigns select_hunk<CR>',
          silent = true,
        },
      }
    end,
  }
}

