return {
  { 'hrsh7th/cmp-nvim-lsp', lazy = true },
  { 'hrsh7th/cmp-buffer', lazy = true },
  { 'hrsh7th/cmp-nvim-lsp-signature-help', lazy = true },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    opts = function(_, opts)
      local cmp = require('cmp')
      opts.mapping = cmp.mapping.preset.insert({
        ['<c-u>'] = cmp.mapping.scroll_docs(-4),
        ['<c-d>'] = cmp.mapping.scroll_docs(4),
        ['<c-e>'] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.abort()
            else
              fallback()
            end
          end,
        }),
        ['<cr>'] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
      })
      opts.sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer' },
      })
    end,
  },
}
