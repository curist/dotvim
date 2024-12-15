return {
  'saghen/blink.cmp',
  version = '*',
  opts = {
    keymap = {
      preset = 'default',
      ['<c-e>'] = {},
      ['<c-j>'] = { 'select_and_accept' },
      ['<c-;>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<c-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<c-d>'] = { 'scroll_documentation_down', 'fallback' },
    },
    completion = {
      documentation = {
        auto_show = true,
        window = { border = 'single' },
      },
      ghost_text = { enabled = true },
    },
    signature = { enabled = true },
  },
}
