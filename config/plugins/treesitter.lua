require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "css",
    "comment",
    "graphql",
    "javascript",
    "typescript",
    "html",
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
