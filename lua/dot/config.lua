local uv = vim.uv or vim.loop
local home = uv.os_homedir()
local playground = home .. '/playground'
local twinkle_root = playground .. '/rust/twinkle'

local M = {
  paths = {
    home = home,
    notes = home .. '/notes',
    playground = playground,
    twinkle_root = twinkle_root,
    twinkle_lsp = twinkle_root .. '/target/release/twk',
    twinkle_parser = twinkle_root .. '/tree-sitter-twinkle',
  },
  terminal = {
    shell = vim.env.SHELL or 'fish',
    wait_wrapper = 'petc',
  },
}

local ok, overrides = pcall(require, 'dot.local')
if ok and type(overrides) == 'table' then
  M = vim.tbl_deep_extend('force', M, overrides)
end

return M
