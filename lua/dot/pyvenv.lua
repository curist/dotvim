local M = {}

local current_venv = nil
local prev_system_bin_path = nil

local notify = {}
for k in pairs(vim.log.levels) do
  notify[k:lower()] = function(msg)
    return vim.notify(msg, vim.log.levels[k])
  end
end

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

local function setup_lsp(lsp_name, python_path)
  local clients = vim.lsp.get_clients({ name = lsp_name })
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = python_path })
    else
      client.config.settings =
        vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = python_path } })
    end
    client.notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

local function setup_lsps(python_path)
  for _, lsp in ipairs({ 'pyright', 'ruff' }) do
    setup_lsp(lsp, python_path)
  end
end

M.activate = function(path)
  if current_venv then
    M.deactivate()
  end

  current_venv = vim.fn.resolve((path .. '/.venv'))
  local bin_path = get_bin_path(current_venv)
  local python_path = get_python_path(current_venv)
  if not python_path then
    notify.error("The python path '" .. python_path .. "' does not exist.")
    return
  end
  prev_system_bin_path = vim.fn.getenv('PATH')
  vim.fn.setenv('PATH', (bin_path .. ':' .. prev_system_bin_path))
  vim.fn.setenv('VIRTUAL_ENV', current_venv)
  setup_lsps(python_path)
  return notify.info('Activated python virtual env')
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
