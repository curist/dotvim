local M = {}

function M.each(coll, cb)
  for i, v in ipairs(coll) do
    cb(v, i)
  end
end

function M.map(coll, cb)
  local result = {}
  for i, v in ipairs(coll) do
    result[i] = cb(v, i)
  end
  return result
end

function M.mapf(coll, cb)
  local result = {}
  for i, v in ipairs(coll) do
    result[i] = function() return cb(v, i) end
  end
  return result
end

function M.range(n)
  local result = {}
  for i = 1, n do
    table.insert(result, i)
  end
  return result
end

function M.filter(coll, pred)
  local result = {}
  for i, v in ipairs(coll) do
    local _1_
    if pred(v, i) then
      _1_ = v
    else
    _1_ = nil
    end
    result[(#result + 1)] = _1_
  end
  return result
end

function M.reduce(coll, cb, ...)
  local rest = {...}
  local init_value = rest[1]
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

function M.pipe(fns)
  return function(arg)
    for _, fn in ipairs(fns) do
      arg = fn(arg)
    end
    return arg
  end
end

function M.head(coll, n)
  n = n or 1
  return {unpack(coll, 1, n)}
end

function M.chunks(coll, n)
  local result = {}
  for i = 1, #coll, n do
    table.insert(result, {unpack(coll, i, (i + n - 1))})
  end
  return result
end

function M.keys(coll)
  local keys = {}
  for k, _ in pairs(coll) do
    table.insert(keys, k)
  end
  return keys
end

function M.bind(fn, ...)
  local args = {...}
  return function(...)
    local more_args = {...}
    return fn(unpack(M.concat(args, more_args)))
  end
end

function M.rbind(fn, ...)
  local args = {...}
  return function(...)
    local more_args = {...}
    return fn(unpack(M.concat(more_args, args)))
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

function M.starts_with(str, start)
  return (start == str:sub(1, #start))
end

function M.ends_with(str, _end)
  return ((_end == "") or (_end == str:sub(( - #_end))))
end

function M.chars(s)
  local result = {}
  for i = 1, #s do
    result[i] = s:sub(i, i)
  end
  return result
end

return M
