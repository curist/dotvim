local prefix_ignore = { '.git' }
local suffix_ignore = { 'COMMIT_EDITMSG' }

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
      for _, ig in ipairs(suffix_ignore) do
        if ends_with(v, ig) then
          ignored = true
          break
        end
      end
      if not ignored then
      end
      if not ignored then
        local filepath = string.sub(v, #pwd + 2)
        for _, ig in ipairs(prefix_ignore) do
          if starts_with(filepath, ig) then
            ignored = true
            break
          end
        end

        if not ignored then
          table.insert(local_oldfiles, filepath)
        end
      end
    end
  end
  return local_oldfiles
end
