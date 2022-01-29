local dot = require('dot.utils')

local M = {}

local prefix_ignore = {'.git/'}
local suffix_ignore = {'COMMIT_EDITMSG'}


local function starts_with(str, start)
  return (start == str:sub(1, #start))
end

local function ends_with(str, _end)
  return ((_end == "") or (_end == str:sub(( - #_end))))
end

local function get_all_files()
  local function _1_(_241)
    return vim.api.nvim_buf_get_name(_241)
  end
  return dot.concat(dot.map(vim.call("fzf#vim#_buflisted_sorted"), _1_), vim.v.oldfiles)
end
local function filter_filepath(pwd, orig_filepath)
  local filepath = orig_filepath:sub((#pwd + 2))
  local function _1_(_241)
    return ends_with(filepath, _241)
  end
  local function _2_(_241)
    return starts_with(filepath, _241)
  end
  return not (not starts_with(orig_filepath, pwd) or dot.some(suffix_ignore, _1_) or dot.some(prefix_ignore, _2_))
end
local function filter_buffers(bufs)
  local pwd = vim.call("getcwd")
  local function _1_(_241)
    return filter_filepath(pwd, vim.api.nvim_buf_get_name(_241))
  end
  return dot.filter(bufs, _1_)
end
function M.fzf_local_history()
  local pwd = vim.call("getcwd")
  local files
  local function _1_(_241)
    return filter_filepath(pwd, _241)
  end
  local function _2_(_241)
    return _241:sub((2 + #pwd))
  end
  files = dot.map(dot.filter(get_all_files(), _1_), _2_)
  return vim.call("fzf#vim#_uniq", files)
end

function M.altfile()
  local bufs = vim.call("fzf#vim#_buflisted_sorted")
  local filtered_bufs = filter_buffers(bufs)
  local _1_ = #filtered_bufs
  if (_1_ == 0) then
    return "no-can-do"
  elseif (_1_ == 1) then
    return vim.api.nvim_set_current_buf(filtered_bufs[1])
  else
    local _ = _1_
    return vim.api.nvim_set_current_buf(filtered_bufs[2])
  end
end

function M.dirs(path)
  local root = vim.fn.expand(path)
  local paths = vim.fn.split(vim.fn.glob(root .. '/*/'))
  return dot.map(paths, function(p)
    return p:gsub('^'..root..'/', ''):gsub('/$', '')
  end)
end

return M

