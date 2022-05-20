local ts_utils = require 'nvim-treesitter.ts_utils'
local query = vim.treesitter.query;
local M = {}

function M.run_nearest_zig_test()
  local curr_node = ts_utils.get_node_at_cursor()
  local function is_test_node(node)
    return tostring(node) == '<node TestDecl>'
  end
  while curr_node and not is_test_node(curr_node) do
    curr_node = curr_node:parent()
  end
  if not is_test_node(curr_node) then
    return
  end
  local test_name = query.get_node_text(curr_node:named_child(0), 0)
  local filename = vim.fn.expand('%:~:.')
  local base_test_cmd = 'VT zig test --test-filter %s --cache-dir zig-cache %s'
  vim.fn.execute((base_test_cmd):format(test_name, filename))
end

function M.run_zig_test()
  local filename = vim.fn.expand('%:~:.')
  local base_test_cmd = 'VT zig test --cache-dir zig-cache %s'
  vim.fn.execute((base_test_cmd):format(filename))
end

return M
