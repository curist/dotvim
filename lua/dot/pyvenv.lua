-- :fennel:1738642442
local M = {}
local current_venv = nil
local prev_system_bin_path = nil
local vim = (_G.vim or {})
local notify = {}
for k in pairs(vim.log.levels) do
  local function _1_(msg)
    return vim.notify(msg, vim.log.levels[k])
  end
  notify[k:lower()] = _1_
end
local function get_bin_path(venv_path)
  if (nil ~= venv_path) then
    local p = venv_path
    return vim.fn.resolve((p .. "/bin"))
  else
    return nil
  end
end
local function get_python_path(venv_path)
  local _3_ = get_bin_path(venv_path)
  if (nil ~= _3_) then
    local p = _3_
    return vim.fn.resolve((p .. "/python"))
  else
    return nil
  end
end
M["init-venv"] = function(path)
end
local lsps = {"pyright", "ruff"}
local function setup_lsp(lsp_name, python_path)
  local clients = vim.lsp.get_clients({name = lsp_name})
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend("force", client.settings.python, {pythonPath = python_path})
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {python = {pythonPath = python_path}})
    end
    client.notify("workspace/didChangeConfiguration", {settings = nil})
  end
  return nil
end
local function setup_lsps(python_path)
  for _, lsp in ipairs(lsps) do
    setup_lsp(lsp, python_path)
  end
  return nil
end
M.activate = function(path)
  if current_venv then
    M.deactivate()
  else
  end
  current_venv = vim.fn.resolve((path .. "/.venv"))
  local bin_path = get_bin_path(current_venv)
  local python_path = get_python_path(current_venv)
  if (nil == python_path) then
    notify.error(("The python path '" .. python_path .. "' does not exist."))
    return
  else
  end
  prev_system_bin_path = vim.fn.getenv("PATH")
  vim.fn.setenv("PATH", (bin_path .. ":" .. prev_system_bin_path))
  vim.fn.setenv("VIRTUAL_ENV", current_venv)
  setup_lsps(python_path)
  return notify.info("Activated python virtual env")
end
M.deactivate = function()
  vim.fn.setenv("VIRTUAL_ENV", "")
  current_venv = nil
  if (nil ~= prev_system_bin_path) then
    local p = prev_system_bin_path
    vim.fn.setenv("PATH", p)
    prev_system_bin_path = nil
    return nil
  else
    return nil
  end
end
return M