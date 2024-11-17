return {
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      local cmp = require'cmp'
      opts.mapping = cmp.mapping.preset.insert({
        ['<c-u>'] = cmp.mapping.scroll_docs(-4),
        ['<c-d>'] = cmp.mapping.scroll_docs(4),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<cr>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      })
      opts.sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer' },
      })
    end,
  },
}
