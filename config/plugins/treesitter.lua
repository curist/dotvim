require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "css",
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
