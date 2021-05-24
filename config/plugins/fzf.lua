local ignore = { 'COMMIT_EDITMSG' }

function starts_with(str, start)
   return str:sub(1, #start) == start
end

function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

function _G._fzf_local_history()
  local oldfiles = vim.v.oldfiles
  local pwd = vim.call 'getcwd'
  local local_oldfiles = {}
  for _, v in ipairs(oldfiles) do
    if starts_with(v, pwd) then
      local ignored = false
      for _, ig in ipairs(ignore) do
        if ends_with(v, ig) then
          ignored = true
          break
        end
      end
      if not ignored then
        table.insert(local_oldfiles, string.sub(v, #pwd + 2))
      end
    end
  end
  return local_oldfiles
end
