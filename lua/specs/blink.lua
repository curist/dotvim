return {
  "saghen/blink.cmp",
  version = "*",
  -- No dependencies needed for native sources
  lazy = false,
  opts = {
    sources = {
      default = { 'lsp', 'buffer', 'path' },
    },
    completion = {
      ghost_text = { enabled = false },
      documentation = { auto_show = false },
    },
    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      },
    },
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
