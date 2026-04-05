local dot = require('dot.utils')
local dot_cfg = require('dot.config')

local M = {}

local prefix_ignore = { '.git/' }
local suffix_ignore = { 'COMMIT_EDITMSG' }

local function filter_filepath(pwd, orig_filepath)
  local filepath = orig_filepath:sub((#pwd + 2))
  local function _1_(_241)
    return vim.endswith(filepath, _241)
  end
  local function _2_(_241)
    return vim.startswith(filepath, _241)
  end
  return not (not vim.startswith(orig_filepath, pwd) or dot.some(suffix_ignore, _1_) or dot.some(prefix_ignore, _2_))
end

local function get_buflisted_sorted()
  local buffers = {}
  local curbuf = vim.fn.bufnr()
  local bufnrs = dot.filter(vim.api.nvim_list_bufs(), function(buf)
    local name = vim.api.nvim_buf_get_name(buf)
    if name == '' then
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

function M.cwd_oldfiles(opts)
  local core = require('fzf-lua.core')
  local config = require('fzf-lua.config')
  opts = config.normalize_opts(opts, config.globals.oldfiles)
  if not opts then
    return
  end

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
    if not file then
      return
    end
    if file_set[file] then
      return
    end

    file_set[file] = true

    local path = underCwd(file) and trimPath(file) or file
    table.insert(results, path)
  end

  dot.each(get_buflisted_sorted(), function(bufnr)
    local file = vim.api.nvim_buf_get_name(bufnr)
    if not vim.uv.fs_stat(file) then
      return
    end
    if bufnr == current_buffer then
      local path = underCwd(file) and trimPath(file) or file
      opts.fzf_opts['--header'] = path
      return
    end
    append_result(file)
  end)

  dot.each(vim.v.oldfiles, function(file)
    if file_set[file] then
      return
    end
    if not underCwd(file) then
      return
    end
    if not vim.uv.fs_stat(file) then
      return
    end
    if file == current_file then
      return
    end
    if vim.fn.isdirectory(file) == 1 then
      return
    end

    append_result(file)
  end)

  local contents = function(cb)
    dot.each(results, function(x)
      if not x then
        return
      end

      cb(x, function(err)
        if err then
          return
        end
        -- close the pipe to fzf, this
        -- removes the loading indicator in fzf
        cb(nil, function() end)
      end)
    end)
    cb(nil)
  end

  return core.fzf_exec(contents, opts)
end

function M.recent_projects()
  local core = require('fzf-lua.core')
  local base = dot_cfg.paths.playground .. '/'
  local opts = {
    prompt = vim.fn.fnamemodify(dot_cfg.paths.playground, ':~') .. '/ ',
    fzf_opts = { ['--no-multi'] = '' },
    complete = function(selected)
      if not selected or selected[1] == 'esc' then
        return
      end
      local path = base .. '/' .. selected[1]
      vim.api.nvim_set_current_dir(path)
      vim.fn.execute('Oil .')
    end,
  }

  local function matched_project_path(filepath)
    return filepath:match('^' .. base .. '[^/]+/[^/]+/')
  end

  local projects = vim.fn.glob(base .. '*/*/', nil, true)
  local projects_score = {}
  -- init projects_score to 0
  for _, path in pairs(projects) do
    projects_score[path] = 0
  end

  local oldfiles = vim.v.oldfiles
  for i = #oldfiles, 1, -1 do
    local oldfile = oldfiles[i]
    local score = #oldfiles - i
    local path = matched_project_path(oldfile)
    if path and projects_score[path] then
      -- don't accumulate score, but just count recency
      projects_score[path] = score
    end
  end

  table.sort(projects, function(a, b)
    local score_a = projects_score[a]
    local score_b = projects_score[b]
    if score_a == score_b then
      return a < b
    end
    return score_a > score_b
  end)

  for i, path in ipairs(projects) do
    projects[i] = path:gsub('^' .. base, '')
  end

  return core.fzf_exec(projects, opts)
end

M.closeAllFloatingWindows = function()
  local closed_windows = 0
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then        -- is_floating_window?
      vim.api.nvim_win_close(win, false) -- do not force
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
  vim.cmd.noh()
  M.closeAllFloatingWindows()
end

M.openTerm = function(opts)
  if not opts then
    opts = {}
  end

  local kind = opts.kind or 'tab'
  local cmd = opts.cmd
  local use_cwd = opts.use_cwd
  local current_base_path = vim.fn.expand('%:p:h')

  local cwd = vim.fn.getcwd()
  if use_cwd then
    if vim.startswith(current_base_path, 'oil') then
      cwd = require('oil').get_current_dir() or current_base_path
    else
      cwd = current_base_path
    end
  end

  local default_shell = dot_cfg.terminal.shell
  if not cmd or cmd == '' then
    cmd = default_shell
  end

  local wait_wrapper = dot_cfg.terminal.wait_wrapper
  if not opts.nowait and wait_wrapper and cmd ~= default_shell then
    cmd = wait_wrapper .. ' ' .. cmd
  end

  if kind == 'split' then
    -- Split pane in current tmux session
    local exec_cmd = { 'tmux', 'split-window', '-h', '-c', cwd, cmd }
    vim.system(exec_cmd)
  else
    -- Create new tmux window
    local exec_cmd = { 'tmux', 'new-window', '-c', cwd, cmd }
    vim.system(exec_cmd)
  end
end

return M
