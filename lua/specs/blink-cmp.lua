return {
  'saghen/blink.cmp',
  version = 'v0.*',
  opts = {
    keymap = {
      preset = 'default',
      ['<c-e>'] = {},
      ['<c-;>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<c-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<c-d>'] = { 'scroll_documentation_down', 'fallback' },
    },
    signature = { enabled = true },
  },
}
