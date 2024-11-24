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
    ft = { 'fennel', 'lua' }, -- etc
    lazy = true,
    init = function()
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g['conjure#debug'] = true
    end,

    -- Optional cmp-conjure integration
  },
}
