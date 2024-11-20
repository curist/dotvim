vim.diagnostic.config({ virtual_text = false })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp-attach', {}),
  callback = function(event)
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = event.buf })

    local function nn(lhs, rhs, desc)
      desc = desc or ''
      vim.keymap.set("n", lhs, rhs, { buffer = event.buf, silent = true, desc = desc })
    end

    -- Mappings.
    nn("<leader>ld", vim.diagnostic.open_float, 'Diagnostic')
    nn("<leader>lq", vim.diagnostic.setloclist, 'Send diagnostic to quickfix')
    nn("<leader>la", vim.lsp.buf.code_action, 'Code action')
    nn("<leader>lr", vim.lsp.buf.rename, "Rename")
    nn("<leader>ls", require('fzf-lua').lsp_document_symbols, 'Document symbols')
    nn("<leader>lS", require('fzf-lua').lsp_workspace_symbols, 'Workspace symbols')

    nn("gD", vim.lsp.buf.declaration, 'Goto declaration')
    nn("gd", vim.lsp.buf.definition, 'Goto definition')
    nn("gi", vim.lsp.buf.implementation, 'Implementations')
    nn("gr", vim.lsp.buf.references, 'References')
    nn("K", vim.lsp.buf.hover, 'Hover doc')
    vim.keymap.set("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {
      buffer = event.buf,
      silent = true,
      desc = 'Show signature help',
    })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      nn('<leader>lh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, 'Toggle inlay hints')
    end
  end,
})

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.lsp.start({
      name = "clangd",
      cmd = { "clangd" },
      single_file_support = true,
      root_dir = vim.fs.dirname(vim.fs.find({
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        ".git",
      }, { upward = true })[1]),
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    vim.lsp.start({
      name = "gopls",
      cmd = { "gopls" },
      single_file_support = true,
      root_dir = vim.fs.dirname(vim.fs.find({
        "go.mod",
        ".git",
      }, { upward = true })[1]),
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "zig" },
  callback = function()
    vim.lsp.start({
      name = "zls",
      cmd = { "zls" },
      single_file_support = true,
      root_dir = vim.fs.dirname(vim.fs.find({
        "build.zig",
        ".git",
      }, { upward = true })[1]),
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  callback = function()
    vim.lsp.start({
      name = "lua_ls",
      cmd = { "lua-language-server" },
      single_file_support = true,
      root_dir = vim.fs.dirname(vim.fs.find({
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        ".git",
      }, { upward = true })[1]),
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'dart' },
  callback = function()
    vim.lsp.start({
      name = 'dartls',
      cmd = { 'dart', 'language-server', '--protocol=lsp' },
      root_dir = vim.fs.dirname(vim.fs.find({
        'pubspec.yaml',
        '.git',
      }, { upward = true })[1]),
      init_options = {
        onlyAnalyzeProjectsWithOpenFiles = true,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
        outline = true,
        flutterOutline = true,
      },
      settings = {
        dart = {
          completeFunctionCalls = true,
          showTodos = true,
        },
      },
    })
  end,
})

return {}
