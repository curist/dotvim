local prefix_ignore = { '.git' }
local suffix_ignore = { 'COMMIT_EDITMSG' }

function starts_with(str, start)
   return str:sub(1, #start) == start
end

function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

function get_all_files()
  local oldfiles = vim.v.oldfiles
  local allfiles = {}
  for _, v in ipairs(vim.call('fzf#vim#_buflisted_sorted')) do
    table.insert(allfiles, vim.api.nvim_buf_get_name(v))
  end
  for _, v in ipairs(oldfiles) do
    table.insert(allfiles, v)
  end
  return allfiles
end

function _G._fzf_local_history()
  local allfiles = get_all_files()
  local pwd = vim.call 'getcwd'
  local local_oldfiles = {}
  for _, v in ipairs(allfiles) do
    repeat
      if not starts_with(v, pwd) then break end

      local filepath = string.sub(v, #pwd + 2)

      local ignored = false
      for _, ig in ipairs(suffix_ignore) do
        if ends_with(filepath, ig) then
          ignored = true
          break
        end
      end

      if ignored then break end

      for _, ig in ipairs(prefix_ignore) do
        if starts_with(filepath, ig) then
          ignored = true
          break
        end
      end

      if ignored then break end

      table.insert(local_oldfiles, filepath)
      break
    until true
  end
  return local_oldfiles
end
