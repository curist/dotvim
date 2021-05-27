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
  },
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<c-m-l>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<c-m-h>"] = "@parameter.inner",
      },
    },
  },
}

