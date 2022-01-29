local dot = require('dot.utils')
local core = require('fzf-lua.core')
local config = require('fzf-lua.config')

local M = {}

local prefix_ignore = {'.git/'}
local suffix_ignore = {'COMMIT_EDITMSG'}


local function starts_with(str, start)
  return (start == str:sub(1, #start))
end

local function ends_with(str, _end)
  return ((_end == "") or (_end == str:sub(( - #_end))))
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

local function get_buflisted_sorted()
  local buffers = {}
  local curbuf = vim.fn.bufnr()
  local bufnrs = dot.filter(vim.api.nvim_list_bufs(), function(buf)
    local name = vim.api.nvim_buf_get_name(buf)
    if name == "" then
      return false
    end
    local loaded = vim.api.nvim_buf_is_loaded(buf)
    return name and loaded
  end)
  for _, bufnr in ipairs(bufnrs) do
    local flag = bufnr == curbuf and '%' or (bufnr == vim.fn.bufnr('#') and '#' or ' ')

    local element = {
      bufnr = bufnr,
      flag = flag,
      info = vim.fn.getbufinfo(bufnr)[1],
    }

    table.insert(buffers, element)
  end
  table.sort(buffers, function(a, b)
    return a.info.lastused > b.info.lastused
  end)
  local sorted_bufnrs = dot.map(buffers, function(buf)
    return buf.bufnr
  end)
  return sorted_bufnrs
end

function M.altfile()
  local bufs = get_buflisted_sorted()
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

function M.cwd_oldfiles(opts)
  opts = config.normalize_opts(opts, config.globals.oldfiles)
  if not opts then return end

  local cwd = vim.fn.getcwd()
  local function underCwd(s)
    return filter_filepath(cwd, s)
  end
  local function trimPath(s)
    return s:sub((2 + #cwd))
  end

  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  local results = {}

  for _, bufnr in ipairs(get_buflisted_sorted()) do
    local file = vim.api.nvim_buf_get_name(bufnr)
    if vim.loop.fs_stat(file) and bufnr ~= current_buffer then
      table.insert(results, file)
    end
  end

  for _, file in ipairs(vim.v.oldfiles) do
    if vim.loop.fs_stat(file) and not vim.tbl_contains(results, file) and file ~= current_file then
      table.insert(results, file)
    end
  end

  results = dot.map(dot.filter(results, underCwd), trimPath)

  local contents = function (cb)
    for _, x in ipairs(results) do
      x = core.make_entry_file(opts, x)
      if x then
        cb(x, function(err)
          if err then return end
          -- close the pipe to fzf, this
          -- removes the loading indicator in fzf
          cb(nil, function() end)
        end)
      end
    end
    cb(nil)
  end

  opts = core.set_header(opts, 2)
  return core.fzf_files(opts, contents)
end

return M

