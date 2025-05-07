return {
  {
    'mason-org/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'denols',
          'ts_ls',
          'gopls',
          'pyright',
          'ruff',
          'clojure_lsp',
          'fennel_ls',
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
