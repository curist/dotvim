-- treesitter related stuff
local M = {}

local function goto_node(node)
  local row, col = node:start()
  vim.api.nvim_win_set_cursor(0, { row + 1, col })
end

function M.get_top_node_at_cursor()
  local node = vim.treesitter.get_node()
  if not node then
    return nil
  end

  while true do
    local parent = node:parent()

    -- stop if node is already the top non-root node
    if not parent or not parent:parent() then
      return parent and node or nil
    end

    node = parent
  end
end

local function get_root_for_position(row, col, bufnr)
  bufnr = bufnr or 0

  local parser = vim.treesitter.get_parser(bufnr)
  if not parser then
    return nil, nil, nil
  end

  local range = { row, col, row, col }
  parser:parse(range)

  local langtree = parser:language_for_range(range)
  if not langtree then
    return nil, nil, nil
  end

  local tree = langtree:tree_for_range(range)
  local root = tree and tree:root() or nil

  return root, tree, langtree
end

local function bsearch_prev_node(current_line)
  local root = get_root_for_position(0, 0)
  local min, max = 1, root:named_child_count()
  while min < max do
    local mid = math.floor((min + max) / 2)
    local node = root:named_child(mid)
    local start_line = node:range()
    if current_line < start_line then
      max = mid
    else
      min = mid + 1
    end
  end
  return root:named_child(min - 1)
end

local function bsearch_next_node(current_line)
  local root = get_root_for_position(0, 0)
  local min, max = 1, root:named_child_count()
  while min < max do
    local mid = math.floor((min + max) / 2)
    local node = root:named_child(mid)
    local start_line = node:range()
    if current_line > start_line then
      min = mid + 1
    else
      max = mid
    end
  end
  return root:named_child(min - 1)
end

function M.print_node_at_cursor()
  local node = vim.treesitter.get_node()

  vim.treesitter.update_selection(0, node)
  vim.schedule(function()
    vim.cmd('silent normal! "py')
  end)

  print('name:')
  for _, item in ipairs(node:field('name')) do
    print(item)
  end
  print('call:')
  for _, item in ipairs(node:field('call')) do
    print(item:type())
  end
  print('item:')
  for _, item in ipairs(node:field('item')) do
    print(item:type())
  end

  local message = node:type()
  while node:parent() ~= nil do
    message = node:parent():type() .. ' > ' .. message
    node = node:parent()
  end
  print(message)
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

function M.goto_top_node_at_cursor()
  local node = M.get_top_node_at_cursor()
  goto_node(node)
end

function M.goto_next_top_node()
  local node = M.get_top_node_at_cursor()
  if node == nil then
    node = bsearch_next_node(vim.fn.line('.'))
  end
  local target = get_next_noncomment_node(node)
  goto_node(target)
end

function M.goto_prev_top_node()
  local node = M.get_top_node_at_cursor()
  if node == nil then
    node = bsearch_prev_node(vim.fn.line('.'))
  end
  local target = get_prev_noncomment_node(node)
  goto_node(target)
end

function M.goto_next_node()
  local node = vim.treesitter.get_node()
  local target = get_next_noncomment_node(node)
  goto_node(target)
end

function M.goto_prev_node()
  local node = vim.treesitter.get_node()
  local target = get_prev_noncomment_node(node)
  goto_node(target)
end

local function find_first_parent_with_different_range(node)
  local function has_same_range(node1, node2)
    local range1 = vim.treesitter.node_to_lsp_range(node1)
    local range2 = vim.treesitter.node_to_lsp_range(node2)
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
  local node = vim.treesitter.get_node()
  goto_node(find_first_parent_with_different_range(node))
end

function M.goto_child_node()
  local node = vim.treesitter.get_node()
  goto_node(node:named_child(0))
end

return M
