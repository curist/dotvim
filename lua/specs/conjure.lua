local function setup_conjure(opts, config_path)
  config_path = config_path or 'conjure'
  if type(opts) ~= 'table' then
    vim.g[config_path] = opts
    return
  end

  for k, v in pairs(opts) do
    setup_conjure(v, config_path .. '#' .. k)
  end
end

return {
  {
    'Olical/conjure',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'fennel', 'lua', 'python', 'racket' },
    init = function()
      setup_conjure({
        filetype = { fennel = 'conjure.client.fennel.nfnl' },
        extract = { tree_sitter = { enabled = true } },
        mapping = { doc_word = 'gk' },
        client = {
          lua = {
            neovim = {
              mapping = {
                reset_env = false,
                reset_all_envs = false,
              },
            },
          },
        },
        highlight = {
          enabled = true,
          timeout = 250,
        },
      })
    end,
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'fennel' },
        callback = function()
          require('fennel').install()
        end,
      })
    end,
  },
}
