return {
  {
    'mason-org/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      vim.lsp.config('pyright', {
        on_attach = function(client)
          -- Disable diagnostics entirely
          client.handlers["textDocument/publishDiagnostics"] = function() end

          local caps = client.server_capabilities
          caps.hoverProvider = true
        end,
      })

      vim.lsp.enable('fennel_ls')
      vim.lsp.enable('gleam')

      require('mason-lspconfig').setup({
        ensure_installed = {
          'emmylua_ls',
          'ts_ls',
          'gopls',
          'pyright',
          'ruff',
          'clojure_lsp',
          'ols', -- odin
        },
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
}
