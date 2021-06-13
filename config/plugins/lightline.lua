vim.g.lightline = {
  colorscheme = 'jellybeans',
  mode_map = {
    n = 'N',
    i = 'I',
    R = 'R',
    v = 'V',
    V = 'VL',
    c = 'C',
    s = 'S',
    S = 'SL',
    t = 'T',
    ['<C-v>'] = 'VB',
    ['<C-s>'] = 'SB',
  },
  tab = {
    active = { 'filename' },
    inactive = { 'filename' },
  },
  active = {
    left = {
      { 'mode' }, { 'fileencoding' }, { 'filename' },
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
  },
  component_function = {
    filename = 'LightlineFilename',
    inactivefilename = 'LightlineInactiveFilename',
    githead = 'LightLineGitHead',
    filetype = 'FileType',
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

function LightLineGitHead()
  return vim.fn['fugitive#Head'](6)
end
bridge 'LightLineGitHead'

function FileType()
  return vim.bo.filetype
end
bridge 'FileType'

function Mod()
  if vim.bo.readonly then
    return ' -'
  elseif vim.bo.modified then
    return ' +'
  end
  return ''
end

