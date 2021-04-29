require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "css",
    "graphql",
    "javascript",
    "typescript",
    "html",
    "vue",
    "lua",
    "jsdoc",
    "json",
  },
  highlight = {
    enable = true,
  },
}
