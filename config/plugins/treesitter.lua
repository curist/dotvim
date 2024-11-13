local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.lx = {
  install_info = {
    url = "~/.config/nvim/plugged/tree-sitter-lx",
    files = {"src/parser.c"},
    branch = "main",
  },
}

-- parser_config.moonbit = {
--   install_info = {
--     url = "~/git/tree-sitter-moonbit",
--     files = {"src/parser.c"},
--     branch = "main",
--   },
-- }

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
    "moonbit"
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

