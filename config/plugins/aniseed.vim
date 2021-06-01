lua << EOF
function string.startsWith(s, start)
  return string.sub(s, 1, #start) == start
end
function _G.isNeovimConfig()
  local currentFile = vim.fn.expand('%:p:h')
  local neovimCfgFolder = vim.fn.expand('~/.config/nvim')
  return currentFile:startsWith(neovimCfgFolder)
end
function _G.compileFennelConfig()
  local fnlFolder = vim.fn.expand('~/.config/nvim/config/fnl')
  require('aniseed.env').init({input = fnlFolder})
end
EOF
au BufWritePost *.fnl call luaeval('isNeovimConfig() and compileFennelConfig()')
