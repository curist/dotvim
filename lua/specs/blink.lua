return {
  "saghen/blink.cmp",
  version = "*",
  -- No dependencies needed for native sources
  event = "InsertEnter",
  opts = {
    sources = {
      default = { 'lsp', 'buffer', 'snippets', 'path' },
    },
    completion = {
      ghost_text = { enabled = true },
      documentation = { auto_show = true },
      menu = {
        draw = { treesitter = { "lsp" } },
      },
    },
    signature = { enabled = true },
    cmdline = { enabled = true },
    keymap = {
      ["<C-j>"] = { "select_and_accept", "fallback" },
      ["<C-;>"] = { "show", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = {},
    },
  },
}
