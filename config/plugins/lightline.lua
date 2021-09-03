vim.g.lightline = {
  colorscheme = 'jellybeans',
  mode_map = {
    n = 'N',
    i = 'I',
    R = 'R',
    v = 'V',
    V = 'VL',
    c = 'C',
    t = 'T',
    [''] = 'VB',
  },
  tab = {
    active = { 'filename' },
    inactive = { 'filename' },
  },
  active = {
    left = {
      { 'mode' }, { 'fileencoding' }, { 'filename' }, { 'gps' }
    },
    right = {
      { 'lineinfo' }, { 'githead' }, { 'filetype' }, { 'fileformat' },
    },
  },
  inactive = {
    left = { { 'inactivefilename' } },
    right = {},
  },
  component = {
    fileencoding = "%{&fenc=='utf-8'?'':&fenc}",
    fileformat = "%{&ff=='unix'?'':&ff}",
    lineinfo = '%3l:%-2c',
    filetype = '%{&filetype}',
    githead = '%{fugitive#Head(6)}',
  },
  component_function = {
    filename = 'LightlineFilename',
    inactivefilename = 'LightlineInactiveFilename',
    gps = 'LightlineLspGps',
  },
}

function bridge(functionName)
  local command = table.concat({
    'function! ' .. functionName .. '()',
      'return luaeval("' .. functionName .. '()")',
    'endfunction',
  }, '\n')
  vim.cmd(command)
end

function LightlineFilename()
  local filename = vim.fn.expand('%:~:.')
  return filename .. Mod()
end
bridge 'LightlineFilename'

function LightlineInactiveFilename()
  if vim.bo.buftype == 'terminal' then
    return 'TERM'
  end
  local filename = vim.fn.expand('%:~:.')
  if filename == '' then
    return 'NONAME'
  end
  return filename .. Mod()
end
bridge 'LightlineInactiveFilename'

function Mod()
  if vim.bo.readonly then
    return ' -'
  elseif vim.bo.modified then
    return ' +'
  end
  return ''
end

_G.LightlineLspGps = (function()
  local gps = require('nvim-gps')
  return function ()
    if not gps.is_available() then
      return ''
    end
    local location = gps.get_location()
    return location
  end
end)()
bridge 'LightlineLspGps'

