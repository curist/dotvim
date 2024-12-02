-- treesitter related stuff
local ts_utils = require('nvim-treesitter.ts_utils')
local M = {}

function M.get_top_node_at_cursor()
  local node = ts_utils.get_node_at_cursor()
  local function is_root(node)
    return not node:parent()
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
  local buf = vim.api.nvim_get_current_buf()
  local text = vim.treesitter.get_node_text(node, buf)
  local joined_text = table.concat(text, '\n')
  local globalfied_text = joined_text:gsub('^local ', '')
  return globalfied_text
end

local function find_sibling_node(node, direction)
  direction = direction or 'next'
  while node ~= nil do
    local sibling
    if direction == 'next' then
      sibling = node:next_named_sibling()
    else
      sibling = node:prev_named_sibling()
    end
    if sibling and node:type() == sibling:type() then
      return node, sibling
    end
    node = node:parent()
  end
end

local function swap_nodes(node1, node2)
  if not node1 or not node2 then
    return
  end
  local ts = ts_utils
  ts.swap_nodes(node1, node2, 0, true)
end

function M.swap_nodes_at_cursor(direction)
  local node = ts_utils.get_node_at_cursor()
  local node1, node2 = find_sibling_node(node, direction)
  swap_nodes(node1, node2)
end

function M.swap_top_nodes_at_cursor(direction)
  local node = M.get_top_node_at_cursor()
  M.swap_nodes(node, direction)
end

function M.print_node_at_cursor()
  local node = ts_utils.get_node_at_cursor()
  print(node, vim.treesitter.get_node_range(node))
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
  if not node then
    return nil
  end
  local parent = node:parent()
  if not parent then
    return nil
  end
  local good_node_indexes = {}
  local count = parent:named_child_count()
  local found_pos = -1
  for i = 0, count - 1 do
    local current_node = parent:named_child(i)
    if not is_comment(current_node) then
      table.insert(good_node_indexes, i)
    end
    if current_node == node then
      found_pos = #good_node_indexes
    end
  end
  if found_pos < 0 then
    return nil
  end
  local target_index = good_node_indexes[(found_pos + delta + count - 1) % count + 1]
  if not target_index then
    return nil
  end
  return parent:named_child(target_index)
end

local function get_next_noncomment_node(node)
  return get_sibling_noncomment_node(node, 'next')
end

local function get_prev_noncomment_node(node)
  return get_sibling_noncomment_node(node, 'prev')
end

function M.goto_parent_node()
  local node = ts_utils.get_node_at_cursor()
  ts_utils.goto_node(node:parent())
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
    return (
      (range1.start.line == range2.start.line and range1.start.character == range2.start.character)
      or (range1['end'].line == range2['end'].line and range1['end'].character == range2['end'].character)
    )
  end
  if not node then
    return nil
  end
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

return M
