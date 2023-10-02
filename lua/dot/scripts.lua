local dot = require 'dot.utils'
local fzf = require 'fzf-lua'
local core = require 'fzf-lua.core'

local M = {}

local prefix_ignore = {'.git/'}
local suffix_ignore = {'COMMIT_EDITMSG'}

local function filter_filepath(pwd, orig_filepath)
  local filepath = orig_filepath:sub((#pwd + 2))
  local function _1_(_241)
    return dot.ends_with(filepath, _241)
  end
  local function _2_(_241)
    return dot.starts_with(filepath, _241)
  end
  return not (not dot.starts_with(orig_filepath, pwd) or dot.some(suffix_ignore, _1_) or dot.some(prefix_ignore, _2_))
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
  local filtered_bufs = dot.filter(bufs, function(bufnr)
    local filename = vim.api.nvim_buf_get_name(bufnr)
    -- TODO: maybe should also filter out vaffle in the future?
    return not dot.starts_with(filename, 'term://')
  end)
  local target_buf = filtered_bufs[2]
  if not target_buf then
    return
  end
  vim.api.nvim_set_current_buf(target_buf)
end

function M.cwd_oldfiles(opts)
  local config = require('fzf-lua.config')
  opts = config.normalize_opts(opts, config.globals.oldfiles)
  if not opts then return end

  local cwd = vim.fn.getcwd()
  local function underCwd(s)
    return filter_filepath(cwd .. '/', s)
  end
  local function trimPath(s)
    return s:sub(2 + #cwd)
  end

  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  local file_set = {}
  local results = {}

  local function append_result(file)
    if not file then return end
    if file_set[file] then return end

    file_set[file] = true

    local path = underCwd(file) and trimPath(file) or file
    table.insert(results, path)
  end

  dot.each(get_buflisted_sorted(), function(bufnr)
    local file = vim.api.nvim_buf_get_name(bufnr)
    if not vim.loop.fs_stat(file) then
      return
    end
    if bufnr == current_buffer then
      local path = underCwd(file) and trimPath(file) or file
      opts.fzf_opts['--header'] = vim.fn.shellescape(path)
      return
    end
    append_result(file)
  end)

  dot.each(vim.v.oldfiles, function(file)
    if file_set[file] then return end
    if not underCwd(file) then return end
    if not vim.loop.fs_stat(file) then return end
    if file == current_file then return end
    if vim.fn.isdirectory(file) == 1 then return end

    append_result(file)
  end)

  local contents = function (cb)
    dot.each(results, function(x)
      if not x then return end

      cb(x, function(err)
        if err then return end
        -- close the pipe to fzf, this
        -- removes the loading indicator in fzf
        cb(nil, function() end)
      end)
    end)
    cb(nil)
  end

  return core.fzf_exec(contents, opts)
end

M.closeAllFloatingWindows = function()
  local closed_windows = 0
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then  -- is_floating_window?
      vim.api.nvim_win_close(win, false)  -- do not force
      closed_windows = closed_windows + 1
    end
  end
  if closed_windows == 0 then
    return
  end
  print(string.format('Closed %d float windows', closed_windows))
end

M.copy_current_file_path = function()
  local filename = vim.fn.expand('%:~:.')
  vim.fn.setreg('p', filename)
end

M.clear_all = function()
  vim.cmd('noh')
  M.closeAllFloatingWindows()
end

M.openTerm = function(opts)
  if not opts then opts = {} end

  local kind = opts.kind or 'tab'
  local cmd = opts.cmd
  local use_cwd = opts.use_cwd or false
  local current_base_path = vim.fn.expand('%:p:h')

  local exec_cmd = '!wezterm cli '

  if kind == 'split' then
    exec_cmd = exec_cmd .. 'split-pane --right'
  else
    exec_cmd = exec_cmd .. 'spawn'
  end

  if use_cwd and not dot.starts_with(current_base_path, 'vaffle') then
    exec_cmd = exec_cmd .. ' --cwd "' .. current_base_path .. '"'
  else
    exec_cmd = exec_cmd .. ' --cwd "' .. vim.fn.getcwd() .. '"'
  end

  if cmd and cmd ~= '' then
    exec_cmd = exec_cmd .. ' -- sh -c "' .. cmd .. '; read"'
  end

  vim.fn.execute(exec_cmd)
end

M.kill_tmux_sessions = function()
  if type(vim.fn.getenv('TMUX')) == 'string' then
    return
  end
  local sessionPath = vim.fn.fnamemodify(vim.fn.serverlist()[1], ':h')
  local sessionFile = sessionPath .. '/tmux-sessions'
  if vim.fn.filereadable(sessionFile) == 1 then
    vim.fn.execute(table.concat({
      '!cat "' .. sessionFile .. '"',
      'xargs -I{} tmux kill-session -t {}'
    }, '|'))
  end
end

return M

