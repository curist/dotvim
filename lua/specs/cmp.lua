return {
  { 'hrsh7th/cmp-nvim-lsp', lazy = true },
  { 'hrsh7th/cmp-path', lazy = true },
  { 'hrsh7th/cmp-buffer', lazy = true },
  { 'hrsh7th/cmp-cmdline', lazy = true },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
    },
    opts = function(_, opts)
      local cmp = require('cmp')
      opts.experimental = { ghost_text = true }

      opts.mapping = cmp.mapping.preset.insert({
        ['<c-u>'] = cmp.mapping.scroll_docs(-4),
        ['<c-d>'] = cmp.mapping.scroll_docs(4),
        ['<c-j>'] = cmp.mapping.confirm({ select = true }),
        ['<c-e>'] = cmp.mapping({
          i = function(fallback)
            fallback()
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
          c = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
        }),
      })
      opts.sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
