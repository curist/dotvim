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

function filter_filepath(pwd, orig_filepath)
  local pwd = vim.call 'getcwd'

  if not starts_with(orig_filepath, pwd) then
    return false
  end

  local filepath = string.sub(orig_filepath, #pwd + 2)

  for _, ig in ipairs(suffix_ignore) do
    if ends_with(filepath, ig) then
      return false
    end
  end

  for _, ig in ipairs(prefix_ignore) do
    if starts_with(filepath, ig) then
      return false
    end
  end

  return true
end

function filter_buffers(bufs)
  local pwd = vim.call 'getcwd'
  local filtered_bufs = {}
  for _, v in ipairs(bufs) do
    local filepath = vim.api.nvim_buf_get_name(v)
    if filter_filepath(pwd, filepath) then
      table.insert(filtered_bufs, v)
    end
    if #filtered_bufs > 1 then
      break
    end
  end
  return filtered_bufs
end

function _G._fzf_local_history()
  local allfiles = get_all_files()
  local pwd = vim.call 'getcwd'
  local local_oldfiles = {}
  for _, v in ipairs(allfiles) do
    if filter_filepath(pwd, v) then
      local filepath = string.sub(v, #pwd + 2)
      table.insert(local_oldfiles, filepath)
    end
  end
  return local_oldfiles
end

function _G.altfile()
  local bufs = filter_buffers(vim.call('fzf#vim#_buflisted_sorted'))
  if #bufs == 1 then
    vim.api.nvim_set_current_buf(bufs[1])
  elseif #bufs > 1 then
    vim.api.nvim_set_current_buf(bufs[2])
  end
end
