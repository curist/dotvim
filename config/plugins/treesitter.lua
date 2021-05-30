require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "css",
    "comment",
    "graphql",
    "javascript",
    "typescript",
    "html",
    "vue",
    "lua",
    "jsdoc",
    "json",
    "jsonc",
    "regex",
  },
  highlight = {
    enable = true,
  },
}

