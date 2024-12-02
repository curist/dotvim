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
    ft = { 'fennel', 'lua', 'janet' },
    init = function()
      setup_conjure({
        extract = { tree_sitter = { enabled = true } },
        mapping = { doc_word = 'gk' },
        highlight = {
          enabled = true,
          timeout = 250,
        },
      })
    end,
  },
}
