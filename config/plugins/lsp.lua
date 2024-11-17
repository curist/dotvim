vim.diagnostic.config({ virtual_text = false })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    vim.api.nvim_buf_set_option(event.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { buffer = event.buf, silent = true }
    local function nn(lhs, rhs)
      vim.keymap.set("n", lhs, rhs, opts)
    end

    -- Mappings.
    nn("<leader>ld", vim.diagnostic.open_float)
    nn("<leader>lq", vim.diagnostic.setloclist)
    nn("<leader>la", vim.lsp.buf.code_action)

    nn("gD", vim.lsp.buf.declaration)
    nn("gd", vim.lsp.buf.definition)
    nn("gi", vim.lsp.buf.implementation)
    nn("gr", vim.lsp.buf.references)
    nn("K", vim.lsp.buf.hover)
    nn("<leader>lrn", vim.lsp.buf.rename)
    vim.keymap.set("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

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
