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
        float = {
          transparent = true,
          solid = false,
        },
        custom_highlights = function(colors)
          return {
            WinSeparator = { fg = colors.overlay0 },
          }
        end,
      })
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
