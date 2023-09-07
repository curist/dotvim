local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.lx = {
  install_info = {
    url = "~/.config/nvim/plugged/tree-sitter-lx",
    files = {"src/parser.c"},
    branch = "main",
  },
}

require'nvim-treesitter.configs'.setup {
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
    "lx",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  matchup = {
    enable = true,
    disable_virtual_text = true,
  },
}

require 'dot.ts'.fix_ts()
