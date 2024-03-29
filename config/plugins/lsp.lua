vim.diagnostic.config({ virtual_text = false })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.api.nvim_buf_set_option(args.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { buffer = args.buf, silent = true }
    local function nn(lhs, rhs) vim.keymap.set('n', lhs, rhs, opts) end

    -- Mappings.
    nn('<leader>ld', vim.diagnostic.open_float)
    nn('<leader>lq', vim.diagnostic.setloclist)
    nn('<leader>la', vim.lsp.buf.code_action)

    nn('gD', vim.lsp.buf.declaration)
    nn('gd', vim.lsp.buf.definition)
    nn('gi', vim.lsp.buf.implementation)
    nn('gr', vim.lsp.buf.references)
    nn('K', vim.lsp.buf.hover)
    nn('<leader>lrn', vim.lsp.buf.rename)
    vim.keymap.set('i', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  end
})

-- TOOD: setup tsserver, denols
-- tsserver: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
-- denols: root patterns deno.json, mod.ts

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'c', 'cpp'},
  callback = function()
    vim.lsp.start {
      name = 'clangd',
      cmd = {'clangd'},
      single_file_support = true,
      root_dir = vim.fs.dirname(vim.fs.find({
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        '.git'
      }, { upward = true })[1]),
    }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    vim.lsp.start {
      name = 'gopls',
      cmd = {'gopls'},
      single_file_support = true,
      root_dir = vim.fs.dirname(vim.fs.find({
        'go.mod',
        '.git'
      }, { upward = true })[1]),
    }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "zig" },
  callback = function()
    vim.lsp.start {
      name = 'zls',
      cmd = {'zls'},
      single_file_support = true,
      root_dir = vim.fs.dirname(vim.fs.find({
        'build.zig',
        '.git'
      }, { upward = true })[1]),
    }
  end,
})
