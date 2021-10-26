require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "css",
    "go",
    "graphql",
    "javascript",
    "typescript",
    "html",
    "clojure",
    "fennel",
    "vue",
    "lua",
    "jsdoc",
    "json",
  },
  highlight = {
    enable = true,
  },
  pairs = {
    enable = true,
    keymaps = {
      goto_partner = "%"
    }
  }
}
