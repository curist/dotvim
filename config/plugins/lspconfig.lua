local u = require('dot.utils')
local nvim_lsp = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')
local lsp_installer_servers = require('nvim-lsp-installer.servers')

local function nn(...) vim.keymap.set('n', ...) end

-- Mappings.
nn('<leader>ld', vim.diagnostic.open_float)
nn('<leader>lq', vim.diagnostic.setloclist)
nn('<leader>la', vim.lsp.buf.code_action)

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  nn('gD', vim.lsp.buf.declaration)
  nn('gd', vim.lsp.buf.definition)
  nn('gi', vim.lsp.buf.implementation)
  nn('gr', vim.lsp.buf.references)
  nn('K', vim.lsp.buf.hover)
  nn('<leader>lrn', vim.lsp.buf.rename)
  vim.keymap.set('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {
    buffer = bufnr,
  })

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    nn('<leader>lf', vim.lsp.buf.formatting)
  elseif client.resolved_capabilities.document_range_formatting then
    nn('<leader>lf', vim.lsp.buf.range_formatting)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { 'gopls', 'tsserver', 'clojure_lsp', 'vuels', 'sumneko_lua' }
function installLspServer(lsp)
  local ok, server = lsp_installer_servers.get_server(lsp)
  if not ok then
    error('bad LSP: ' .. lsp)
  end
  if not server:is_installed() then
    server:install()
  end
end
function setupLspServer(lsp)
  nvim_lsp[lsp].setup {
    autostart = true,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 500,
    },
  }
end
u.each(servers, installLspServer)

vim.diagnostic.config({ virtual_text = false })

lsp_installer.on_server_ready(function(server)
  local opts = {
    autostart = true,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 500,
    },
  }

  -- (optional) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end

  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)
