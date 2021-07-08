-- treesitter related stuff
local ts_utils = require 'nvim-treesitter.ts_utils'
local M = { textobj = {} }

function M.get_top_node_at_cursor()
  local node = ts_utils.get_node_at_cursor()
  local function is_root(node)
    local node_string = tostring(node)
    return node_string == '<node program>' or
      node_string == '<node source_file>'
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

function M.print_node_at_cursor()
  local node = ts_utils.get_node_at_cursor()
  print(node, ts_utils.get_node_range(node))
  ts_utils.update_selection(0, node)
  vim.schedule(function()
    vim.cmd('silent normal! "py')
  end)
end

local function get_sibling_noncomment_node(node, direction)
  local delta = direction == 'prev' and -1 or 1
  local function is_comment(node)
    return vim.fn.stridx(tostring(node), 'comment') >= 0
  end
  if not node then return nil end
  local parent = node:parent()
  if not parent then return nil end
  local good_node_indexes = {}
  local count = parent:named_child_count()
  local found_pos = 0
  for i = 0, count - 1 do
    local current_node = parent:named_child(i)
    if not is_comment(current_node) then
      table.insert(good_node_indexes, i)
    end
    if current_node == node then
      found_pos = #good_node_indexes
    end
  end
  if found_pos == 0 then return nil end
  local target_index = good_node_indexes[found_pos + delta]
  if not target_index then return nil end
  return parent:named_child(target_index)
end

local function get_next_noncomment_node(node)
  return get_sibling_noncomment_node(node, 'next')
end

local function get_prev_noncomment_node(node)
  return get_sibling_noncomment_node(node, 'prev')
end

function M.goto_top_node_at_cursor()
  local node = M.get_top_node_at_cursor()
  ts_utils.goto_node(node)
end

function M.goto_next_top_node()
  local node = M.get_top_node_at_cursor()
  local target = get_next_noncomment_node(node)
  ts_utils.goto_node(target)
end

function M.goto_prev_top_node()
  local node = M.get_top_node_at_cursor()
  local target = get_prev_noncomment_node(node)
  ts_utils.goto_node(target)
end

function M.goto_next_node()
  local node = ts_utils.get_node_at_cursor()
  local target = get_next_noncomment_node(node)
  ts_utils.goto_node(target)
end

function M.goto_prev_node()
  local node = ts_utils.get_node_at_cursor()
  local target = get_prev_noncomment_node(node)
  ts_utils.goto_node(target)
end

local function find_first_parent_with_different_range(node)
  local function has_same_range(node1, node2)
    local range1 = ts_utils.node_to_lsp_range(node1)
    local range2 = ts_utils.node_to_lsp_range(node2)
    return ((
      range1.start.line == range2.start.line and
      range1.start.character == range2.start.character
    ) or (
      range1['end'].line == range2['end'].line and
      range1['end'].character == range2['end'].character
    ))
  end
  if not node then return nil end
  local parent = node:parent()
  while parent do
    if not has_same_range(parent, node) then
      break
    end
    parent = parent:parent()
  end
  return parent
end

function M.goto_parent_node()
  local node = ts_utils.get_node_at_cursor()
  ts_utils.goto_node(find_first_parent_with_different_range(node))
end

function M.goto_child_node()
  local node = ts_utils.get_node_at_cursor()
  ts_utils.goto_node(node:named_child(0))
end

local function pos(row, col) return {0, row + 1, col + 1, 0} end
local function get_node_textobj_range(node)
  if not node then return 0 end
  local s_row, s_col, e_row, e_col = ts_utils.get_node_range(node)
  return {'v', pos(s_row, s_col), pos(e_row, e_col)}
end

function M.textobj.root_node()
  local node = M.get_top_node_at_cursor()
  return get_node_textobj_range(node)
end

function M.textobj.func()
  local function is_function(node)
    return vim.endswith(tostring(node), ' function>') or
      vim.endswith(tostring(node), ' local_function>') or
      vim.endswith(tostring(node), ' function_declaration>') or
      vim.endswith(tostring(node), ' method_declaration>')
  end

  local node = ts_utils.get_node_at_cursor()
  while node do
    if is_function(node) then
      break
    end
    node = node:parent()
  end

  return get_node_textobj_range(node)
end

return M
