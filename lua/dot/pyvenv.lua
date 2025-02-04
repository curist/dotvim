local M = {}

local current_venv = nil
local prev_system_bin_path = nil

local function get_bin_path(venv_path)
  if nil ~= venv_path then
    return vim.fn.resolve(venv_path .. '/bin')
  end
end

local function get_python_path(venv_path)
  local path = get_bin_path(venv_path)
  if nil ~= path then
    return vim.fn.resolve(path .. '/python')
  end
end

M.activate = function(path)
  if current_venv then
    M.deactivate()
  end

  path = path or vim.fn.getcwd()

  current_venv = vim.fn.resolve(path .. '/.venv')
  local bin_path = get_bin_path(current_venv)
  local python_path = get_python_path(current_venv)
  if not python_path or vim.fn.executable(python_path) == 0 then
    -- doesn't have a proper venv
    return
  end
  prev_system_bin_path = vim.fn.getenv('PATH')
  vim.fn.setenv('PATH', (bin_path .. ':' .. prev_system_bin_path))
  vim.fn.setenv('VIRTUAL_ENV', current_venv)
  return vim.notify('Activated python virtual env', vim.log.levels.INFO)
end

M.deactivate = function()
  vim.fn.setenv('VIRTUAL_ENV', '')
  current_venv = nil
  if prev_system_bin_path then
    local p = prev_system_bin_path
    vim.fn.setenv('PATH', p)
    prev_system_bin_path = nil
  end
end

return M
