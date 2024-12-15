return {
  'nvim-tree/nvim-web-devicons',
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',
        no_italic = true,
        no_bold = true,
        custom_highlights = function(colors)
          return {
            WinSeparator = { fg = colors.overlay0 },
          }
        end,
      })
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      stiffness = 0.7,
      trailing_stiffness = 0.4,
      distance_stop_animating = 0.3,
      smear_between_neighbor_lines = false,
      legacy_computing_symbols_support = true,
    },
  },
}
