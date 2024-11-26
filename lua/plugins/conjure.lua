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
      vim.g['conjure#extract#tree_sitter#enabled'] = true
      vim.g['conjure#mapping#doc_word'] = 'gk'
    end,
  },
}
