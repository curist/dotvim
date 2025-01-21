vim.diagnostic.config({
  -- underline = false,
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
  float = {
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
    border = 'rounded',
    source = 'if_many',
    prefix = ' ',
    -- scope = 'cursor',
    scope = 'line',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Diagnostic' })
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setqflist, { desc = 'Send diagnostic to quickfix' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', {}),
  callback = function(event)
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = event.buf })

    local function nn(lhs, rhs, desc)
      desc = desc or ''
      vim.keymap.set('n', lhs, rhs, { buffer = event.buf, silent = true, desc = desc })
    end

    -- Mappings.
    nn('<leader>la', vim.lsp.buf.code_action, 'Code action')
    nn('<leader>lr', vim.lsp.buf.rename, 'Rename')
    nn('<leader>ls', require('fzf-lua').lsp_document_symbols, 'Document symbols')
    nn('<leader>lS', require('fzf-lua').lsp_workspace_symbols, 'Workspace symbols')

    nn('gD', vim.lsp.buf.declaration, 'Goto declaration')
    nn('gd', vim.lsp.buf.definition, 'Goto definition')
    nn('gi', vim.lsp.buf.implementation, 'Implementations')
    nn('gr', vim.lsp.buf.references, 'References')
    nn('K', vim.lsp.buf.hover, 'Documentation')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      nn('<leader>lh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, 'Toggle inlay hints')
    end

    if require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc')(vim.fn.getcwd()) then
      if client and client.name == 'tsserver' then
        client.stop()
        return
      end
    end
    if require('lspconfig').util.root_pattern('tsconfig.json')(vim.fn.getcwd()) then
      if client and client.name == 'denols' then
        client.stop()
        return
      end
    end
  end,
})

--[[ leave this here for example for future manual setup
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript" },
  callback = function()
    vim.lsp.start({
      name = "denols",
      cmd = { "deno", "lsp" },
      single_file_support = true,
      root_dir = vim.fs.dirname(vim.fs.find({
        "deno.json",
        ".git",
      }, { upward = true })[1]),
    })
  end,
})
]]
--

return {
  'neovim/nvim-lspconfig',
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    -- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local self_managed_lsp = {
      'gleam',
      'fennel_ls',
      { 'racket_langserver', { filetypes = { 'racket' } } },
    }
    for _, lsp in ipairs(self_managed_lsp) do
      local lsp_name = lsp
      local opts = {}
      if type(lsp) == 'table' then
        lsp_name, opts = lsp[1], lsp[2]
      end
      opts.capabilities = capabilities
      require('lspconfig')[lsp_name].setup(opts)
    end
  end,
}
