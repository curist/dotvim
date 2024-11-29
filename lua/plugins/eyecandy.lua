return {
  'nvim-tree/nvim-web-devicons',
  { 'MunifTanjim/nui.nvim', lazy = true },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      cmdline = {
        view = 'cmdline',
      },
      views = {
        split = { scrollbar = false },
        popup = { scrollbar = false },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = nil,
        },
      },
      health = { checker = false },
    },
    keys = {
      { '<leader>n', '', desc = '+noice' },
      {
        '<leader>nl',
        function()
          require('noice').cmd('last')
        end,
        desc = 'Noice Last Message',
      },
      {
        '<leader>nh',
        function()
          require('noice').cmd('history')
        end,
        desc = 'Noice History',
      },
      {
        '<leader>na',
        function()
          require('noice').cmd('all')
        end,
        desc = 'Noice All',
      },
      {
        '<leader>nd',
        function()
          require('noice').cmd('dismiss')
        end,
        desc = 'Dismiss All',
      },
      {
        '<leader>nt',
        function()
          require('noice').cmd('pick')
        end,
        desc = 'Noice Picker',
      },
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require 'catppuccin'.setup {
        flavour = 'mocha',
        no_italic = true,
        no_bold = true,
        custom_highlights = function(colors)
          return {
            WinSeparator = { fg = colors.overlay0 },
          }
        end,
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
