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
    "css",
    "go",
    "graphql",
    "javascript",
    "typescript",
    "hcl",
    "html",
    "clojure",
    "fennel",
    "vue",
    "lua",
    "jsdoc",
    "json",
    "lx",
  },
  highlight = {
    enable = true,
  },
}

