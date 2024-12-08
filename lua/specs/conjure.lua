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
    'PaterJason/cmp-conjure',
    lazy = true,
    config = function()
      local cmp = require('cmp')
      local config = cmp.get_config()
      table.insert(config.sources, { name = 'conjure' })
      return cmp.setup(config)
    end,
  },
  {
    'Olical/conjure',
    dependencies = { 'PaterJason/cmp-conjure' },
    ft = { 'fennel', 'lua' },
    init = function()
      setup_conjure({
        filetype = { fennel = 'conjure.client.fennel.stdio' },
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
  },
}
