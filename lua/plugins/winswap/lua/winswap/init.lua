local M = {}

local default_config = {
  letters = 'asdfghjkl',
  follow = false,
}

M.config = vim.deepcopy(default_config)

function M.setup(opts)
  M.config = vim.tbl_extend('force', default_config, opts or {})
end

local function get_normal_wins()
  return vim.tbl_filter(function(win)
    return vim.api.nvim_win_get_config(win).relative == ''
  end, vim.api.nvim_tabpage_list_wins(0))
end

local function sort_wins_by_position(wins)
  table.sort(wins, function(a, b)
    local pa = vim.api.nvim_win_get_position(a)
    local pb = vim.api.nvim_win_get_position(b)
    if pa[1] ~= pb[1] then return pa[1] < pb[1] end
    return pa[2] < pb[2]
  end)
  return wins
end

function M.swap(opts)
  opts = vim.tbl_extend('force', { follow = M.config.follow }, opts or {})
  local wins = sort_wins_by_position(get_normal_wins())
  if #wins <= 1 then return end

  local current_win = vim.api.nvim_get_current_win()
  local letters = M.config.letters
  local floats = {}
  local win_map = {}

  local label_idx = 0
  for _, win in ipairs(wins) do
    if win == current_win then goto continue end
    label_idx = label_idx + 1
    if label_idx > #letters then break end
    local letter = letters:sub(label_idx, label_idx)

    local pos = vim.api.nvim_win_get_position(win)
    local width = vim.api.nvim_win_get_width(win)
    local height = vim.api.nvim_win_get_height(win)

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { ' ' .. letter .. ' ' })

    local float_win = vim.api.nvim_open_win(buf, false, {
      relative = 'editor',
      row = pos[1] + math.floor(height / 2),
      col = pos[2] + math.floor((width - 3) / 2),
      width = 3,
      height = 1,
      style = 'minimal',
      focusable = false,
    })

    vim.api.nvim_set_option_value('winhighlight', 'Normal:WinSwapLabel', { win = float_win })

    table.insert(floats, { win = float_win, buf = buf })
    win_map[letter] = win
    ::continue::
  end

  vim.cmd('redraw')
  local ok, char = pcall(vim.fn.getchar)

  for _, f in ipairs(floats) do
    pcall(vim.api.nvim_win_close, f.win, true)
    pcall(vim.api.nvim_buf_delete, f.buf, { force = true })
  end

  if not ok then return end

  local key = type(char) == 'number' and vim.fn.nr2char(char) or char
  local target_win = win_map[key]
  if not target_win or target_win == current_win then return end

  local cur_buf = vim.api.nvim_win_get_buf(current_win)
  local tgt_buf = vim.api.nvim_win_get_buf(target_win)
  vim.api.nvim_win_set_buf(current_win, tgt_buf)
  vim.api.nvim_win_set_buf(target_win, cur_buf)

  if opts.follow then
    vim.api.nvim_set_current_win(target_win)
  end
end

return M
