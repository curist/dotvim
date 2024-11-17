return {
  "nvim-treesitter/nvim-treesitter",
  depedencies = {
    "moonbit-community/moonbit.nvim",
    "curist/tree-sitter-lx",
  },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c",
      "css",
      "go",
      "javascript",
      "typescript",
      "html",
      "lua",
      "jsdoc",
      "json",
    },
    highlight = { enable = true },
    indent = { enable = true },
    matchup = {
      enable = true,
      disable_virtual_text = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "+",
        node_incremental = "+",
        node_decremental = "-",
        scope_incremental = false,
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
