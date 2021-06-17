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
au BufReadPost  *.fnl setlocal omnifunc=v:lua.FennelOmnifunc
]]
