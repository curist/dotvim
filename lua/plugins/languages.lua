return {
  {
    "moonbit-community/moonbit.nvim",
    ft = "moonbit",
    opts = {
      treesitter = { enabled = true },
    },
  },
  {
    "curist/tree-sitter-lx",
    build = ":TSInstall! lx",
    config = function(plugin)
      local plug_dir = plugin.dir .. "/vim"
      vim.opt.rtp:append(plug_dir)
      require("lazy.core.loader").packadd(plug_dir)

      require("nvim-treesitter.parsers").get_parser_configs()["lx"] = {
        filetype = "lx",
        install_info = {
          url = "https://github.com/curist/tree-sitter-lx",
          files = { "src/parser.c" },
          branch = "main",
        },
      }
    end,
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'folke/lazydev.nvim',
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
}
