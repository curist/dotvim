local M = {}

function M.buf_nn(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { buffer = true, silent = true, desc = desc })
end

function M.set_2space_indent()
  vim.bo.autoindent = true
  vim.bo.shiftwidth = 2
  vim.bo.softtabstop = 2
  vim.bo.expandtab = true
end

function M.run_current_file(command, desc)
  M.buf_nn('<localleader>r', function()
    vim.cmd.write()
    local file = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
    vim.cmd('!' .. command .. ' ' .. file)
  end, desc or ('Run with ' .. command))
end

return M
