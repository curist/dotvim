local _2afile_2a = "config/fnl/dot/utils.fnl"
local function map(coll, cb)
  local tbl_0_ = {}
  for i, v in ipairs(coll) do
    tbl_0_[(#tbl_0_ + 1)] = cb(v, i)
  end
  return tbl_0_
end
local function filter(coll, pred)
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
local function reduce(coll, cb, ...)
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
local function concat(coll1, coll2)
  local result = {}
  for _, v in ipairs(coll1) do
    table.insert(result, v)
  end
  for _, v in ipairs(coll2) do
    table.insert(result, v)
  end
  return result
end
local function some(coll, pred)
  for i, v in ipairs(coll) do
    if pred(v, i) then
      return true
    end
  end
  return false
end
local function async_wrap(fn)
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
return {async_wrap = async_wrap, concat = concat, filter = filter, map = map, reduce = reduce, some = some}
