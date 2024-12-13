return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
    keys = function()
      local w = require('dot.utils').bind
      local scripts = require('dot.scripts')
      local gitsigns = require('gitsigns')
      return {
        {
          '<leader>gg',
          w(scripts.openTerm, { cmd = 'lazygit', nowait = true }),
          desc = 'Lazygit',
        },
        {
          '<leader>gb',
          w(gitsigns.blame_line, { full = true }),
          desc = 'Git blame current line',
        },
        {
          '<leader>gB',
          gitsigns.blame,
          desc = 'Git blame current file',
        },
        {
          '<leader>hq',
          w(gitsigns.setqflist, 'all'),
          desc = 'Send git hunks to qflist',
        },
        {
          '<leader>hs',
          gitsigns.stage_hunk,
          desc = 'Stage hunk',
        },
        {
          '<leader>hp',
          gitsigns.preview_hunk,
          desc = 'Stage hunk',
        },
        {
          '<leader>hr',
          gitsigns.reset_hunk,
          desc = 'Reset hunk',
        },
        {
          '<leader>hd',
          gitsigns.toggle_deleted,
          desc = 'Toggle delete hunk',
        },
        {
          ']h',
          w(gitsigns.nav_hunk, 'next'),
          desc = 'Next hunk',
        },
        {
          '[h',
          w(gitsigns.nav_hunk, 'prev'),
          desc = 'Previous hunk',
        },
        {
          'ih',
          mode = { 'o', 'x' },
          ':<C-U>Gitsigns select_hunk<CR>',
          silent = true,
        },
      }
    end,
  },
}
