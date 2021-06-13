function startsWith(s, start)
  return string.sub(s, 1, #start) == start
end
function _G.isNeovimConfig()
  local currentFile = vim.fn.expand('%:p:h')
  local neovimCfgFolder = vim.fn.expand('~/.config/nvim')
  return startsWith(currentFile, neovimCfgFolder)
end
function _G.compileFennelConfig()
  local fnlFolder = vim.fn.expand('~/.config/nvim/config/fnl')
  require('aniseed.env').init({input = fnlFolder})
end
function _G.FennelOmnifunc(findstart, base)
  local raw_result = vim.fn.ConjureOmnifunc(findstart, base)
  if not ('table' == type(raw_result)) then
    return raw_result
  end
  local result = {}
  for _, compl in ipairs(raw_result) do
    if startsWith(compl.word, base) then
      table.insert(result, compl)
    end
  end
  return result
end

vim.cmd [[
au BufWritePost *.fnl call luaeval('isNeovimConfig() and compileFennelConfig()')
au BufReadPost  *.fnl setlocal omnifunc=v:lua.FennelOmnifunc
]]
