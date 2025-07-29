return {
  {
    'mason-org/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require("lspconfig").pyright.setup({
        on_attach = function(client, bufnr)
          -- Disable diagnostics entirely
          client.handlers["textDocument/publishDiagnostics"] = function() end

          local caps = client.server_capabilities
          caps.hoverProvider = true
        end,
      })

      -- manually install fennel-ls, the one on luarocks is outdated
      require("lspconfig").fennel_ls.setup({})

      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'ts_ls',
          'gopls',
          'pyright',
          'ruff',
          'clojure_lsp',
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
