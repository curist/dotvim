return {
  'nvim-tree/nvim-web-devicons',
  {
    'j-hui/fidget.nvim',
    opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function(_, opts)
      opts.flavour = 'mocha'
      opts.no_italic = true
      opts.no_bold = true
      opts.custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.overlay0 },
        }
      end
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
