local ns = vim.api.nvim_create_namespace("VisualCountVirtualText")

local function get_visual()
  local curpos = vim.fn.getcurpos()
  local one = { row = curpos[2] - 1, col = curpos[3] - 1 }
  local two = { row = vim.fn.line('v') - 1, col = vim.fn.col('v') - 1 }

  return { one, two }
end

-- Function to show virtual text with visual selection count
local function show_visual_count()
  local pos = get_visual()

  -- Clear any existing extmarks for virtual text
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

  -- Create the message to show
  local message = ""
  local mode = vim.fn.mode()
  if mode == 'v' then
    if pos[1].row ~= pos[2].row then
      -- multiple lines selection, we don't count chars
      -- too expensive, and that's not our use case anyway
      return nil
    end
    message = string.format(" %d", vim.fn.abs(pos[1].col - pos[2].col) + 1)
  elseif mode == 'V' then
    message = string.format(" %d", vim.fn.abs(pos[1].row - pos[2].row) + 1)
  elseif mode == '' then
    message = string.format(
      " %d x %d",
      vim.fn.abs(pos[1].row - pos[2].row) + 1,
      vim.fn.abs(pos[1].col - pos[2].col) + 1)
  end

  -- Create a new extmark to show the virtual text
  vim.api.nvim_buf_set_extmark(0, ns, pos[1].row, 0, {
    virt_text = { { message, 'Comment' } },
    virt_text_pos = 'eol',  -- Position the text at the end of the line
    hl_mode = 'combine',    -- Combine the highlight with the text
  })
end

-- Set up an autocmd to call the function when the selection changes
vim.api.nvim_create_autocmd({ 'ModeChanged', 'TextChanged', 'CursorMoved', 'CursorMovedI' }, {
  pattern = '*',
  callback = function()
    -- Only update the virtual text in visual mode
    if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' or vim.fn.mode() == '' then
      show_visual_count()
    else
      -- Clear the virtual text when not in visual mode
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    end
  end,
})

return {}
