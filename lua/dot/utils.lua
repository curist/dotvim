local fs = require 'dot.fs'
local ts_utils = require 'nvim-treesitter.ts_utils'

local M = {}

function M.map(coll, cb)
  local tbl_0_ = {}
  for i, v in ipairs(coll) do
    tbl_0_[(#tbl_0_ + 1)] = cb(v, i)
  end
  return tbl_0_
end

function M.range(n)
  local result = {}
  for i = 1, n do
    table.insert(result, i)
  end
  return result
end

function M.filter(coll, pred)
  local tbl_0_ = {}
  for i, v in ipairs(coll) do
    local _1_
    if pred(v, i) then
      _1_ = v
    else
    _1_ = nil
    end
    tbl_0_[(#tbl_0_ + 1)] = _1_
  end
  return tbl_0_
end

function M.reduce(coll, cb, ...)
  local _let_0_ = {...}
  local init_value = _let_0_[1]
  local has_init = not (nil == init_value)
  local start_index
  if has_init then
    start_index = 1
  else
    start_index = 2
  end
  local result
  if has_init then
    result = init_value
  else
    result = coll[1]
  end
  for i = start_index, #coll do
    result = cb(result, coll[i], i)
  end
  return result
end

function M.concat(coll1, coll2)
  local result = {}
  for _, v in ipairs(coll1) do
    table.insert(result, v)
  end
  for _, v in ipairs(coll2) do
    table.insert(result, v)
  end
  return result
end

function M.some(coll, pred)
  for i, v in ipairs(coll) do
    if pred(v, i) then
      return true
    end
  end
  return false
end

function M.bind(fn, ...)
  local args = {...}
  return function()
    return fn(unpack(args))
  end
end

function M.async_wrap(fn)
  return function(...)
    local self = coroutine.running()
    local args = {...}
    local result = nil
    table.insert(args, function(...)
      result = {...}
      coroutine.resume(self, ...)
    end)
    fn(unpack(args))
    if result then
      return unpack(result)
    end
    return coroutine.yield()
  end
end

function M.rasync_wrap(fn)
  return function(...)
    local self = coroutine.running()
    local result = nil

    fn(function(...)
      result = {...}
      coroutine.resume(self, ...)
    end, ...)

    if result then
      return unpack(result)
    end
    return coroutine.yield()
  end
end

function M.with_file(path, fn)
  return pcall(function()
    local fd = fs.open(path)
    local result = fn(fd)
    fs.close(fd)
    return result
  end)
end

--[[ usage
ok, data = with_file('/tmp/fs.lua', function(fd)
  local content = fs.read(fd)
  return content
end)
--]]

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

return M