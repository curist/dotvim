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
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    ft = { 'fennel', 'lua', 'python', 'racket', 'scheme', 'clojure' },
    init = function()
      setup_conjure({
        filetype = {
          fennel = 'conjure.client.fennel.stdio',
          -- fennel = 'conjure.client.fennel.nfnl',
        },
        extract = { tree_sitter = { enabled = true } },
        mapping = { doc_word = 'gk' },
        log = { hud = { ignore_low_priority = true } },
        client = {
          lua = {
            neovim = {
              mapping = {
                reset_env = false,
                reset_all_envs = false,
              },
            },
          },
          scheme = {
            stdio = {
              command = 'chez',
              prompt_pattern = '> $',
              value_prefix_pattern = false,
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
