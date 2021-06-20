-- treesitter related stuff
local ts_utils = require 'nvim-treesitter.ts_utils'
local M = { textobj = {} }

function M.get_top_node_at_cursor()
  local node = ts_utils.get_node_at_cursor()
  local function is_root(node)
    return tostring(node) == '<node program>'
  end
  while node do
    local parent = node:parent()
    if not parent or is_root(parent) then
      break
    end
    node = parent
  end
  return not is_root(node) and node or nil
end

function M.get_top_node_text_at_cursor()
  local node = M.get_top_node_at_cursor()
  local text = ts_utils.get_node_text(node)
  local joined_text = table.concat(text, '\n')
  local globalfied_text = joined_text:gsub('^local ', '')
  return globalfied_text
end

function M.swap_nodes(node, direction)
  direction = direction or 'next'
  local ts = ts_utils
  if not node then return end
  local fn = direction == 'next' and ts.get_next_node or ts.get_previous_node
  local sibling_node = fn(node)
  if not sibling_node then return end
  ts.swap_nodes(node, sibling_node, 0, true)
end

function M.swap_nodes_at_cursor(direction)
  local node = ts_utils.get_node_at_cursor()
  M.swap_nodes(node, direction)
end

function M.swap_top_nodes_at_cursor(direction)
  local node = M.get_top_node_at_cursor()
  M.swap_nodes(node, direction)
end

function M.textobj.root_node()
  -- we are actually returning textobj range
  local node = M.get_top_node_at_cursor()
  if not node then return 0 end
  local s_row, s_col, e_row, e_col = ts_utils.get_node_range(node)
  local function pos(row, col) return {0, row + 1, col + 1, 0} end
  return {'v', pos(s_row, s_col), pos(e_row, e_col)}
end

return M
