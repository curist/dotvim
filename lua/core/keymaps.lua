local dot = require('dot')
local dot_utils = dot.utils
local dot_qf = dot.qf
local scripts = require('dot.scripts')
local w = dot_utils.bind

local function nn(...)
  vim.keymap.set('n', unpack(dot_utils.concat({ ... }, { { silent = true } })))
end

local function vn(...)
  vim.keymap.set('v', unpack(dot_utils.concat({ ... }, { { silent = true } })))
end

nn('<c-c>', '<cmd>nohls<cr>')
nn('<leader>q', dot_qf.toggle_list, { desc = 'Toggle quickfix' })
nn('<leader>u', function()
  if not package.loaded['undotree'] then
    vim.cmd.packadd('nvim.undotree')
  end
  require('undotree').open()
end, { desc = 'Toggle undotree' })

nn('gV', '`[v`]', { desc = 'Select last edited/pasted text' })

nn('](', "<cmd>call search('(', 'sWz')<cr>")
nn('])', "<cmd>call search(')', 'sWz')<cr>")
nn('[(', "<cmd>call search('(', 'bsW')<cr>")
nn('[)', "<cmd>call search(')', 'bsW')<cr>")
nn(']{', "<cmd>call search('{', 'sWz')<cr>")
nn(']}', "<cmd>call search('}', 'sWz')<cr>")
nn('[{', "<cmd>call search('{', 'bsW')<cr>")
nn('[}', "<cmd>call search('}', 'bsW')<cr>")
nn('][', "<cmd>call search('[', 'sWz')<cr>")
nn(']]', "<cmd>call search(']', 'sWz')<cr>")
nn('[[', "<cmd>call search('[', 'bsW')<cr>")
nn('[]', "<cmd>call search(']', 'bsW')<cr>")

vim.keymap.set({ 'i', 'v', 's' }, '<c-c>', '<esc>')
vim.keymap.set('i', '<c-l>', 'Λ')
vn('<leader>e', ':!fennel-eval --stdin<cr>', { desc = 'Fennel evaluate selection' })
nn('<leader>jj', w(scripts.openTerm, { cmd = 'jjui', nowait = true }), { desc = 'jjui' })

nn('<leader>`', '<c-^>', { desc = 'Previous buffer' })
nn('<leader>wd', '<c-w><c-c>', { desc = 'Delete window' })

nn('<leader>.', function()
  vim.fn.setreg('+', vim.fn.expand('%:.'))
  vim.notify('Copied file path: ' .. vim.fn.expand('%:.'))
end, { desc = 'Copy file path' })

nn('J', "<cmd>let p=getpos('.')<bar>join<bar>call setpos('.', p)<cr>")

vim.keymap.set('c', '<c-r><c-l>', w(vim.fn.getline, '.'), { expr = true })

nn('<up>', 'gk<c-y>')
nn('<down>', 'gj<c-e>')
nn('<left>', 'hzh')
nn('<right>', 'lzl')
nn('<s-up>', '<cmd>m .-2<cr>==', { desc = 'Move line up' })
nn('<s-down>', '<cmd>m .+1<cr>==', { desc = 'Move line down' })
vn('<s-up>', ":m '<-2<cr>gv=gv", { desc = 'Move selection up' })
vn('<s-down>', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })

vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

vim.keymap.set({ 'i', 'c' }, '<c-a>', '<home>')
vim.keymap.set('i', '<c-e>', '<end>')

vim.keymap.set('i', '<m-d>', w(os.date, '%Y/%b/%d'), { expr = true })

nn('<m-n>', dot_qf.local_list_next)
nn('<m-p>', dot_qf.local_list_prev)

nn('<leader>ww', function()
  local year = vim.fn.strftime('%Y')
  vim.api.nvim_set_current_dir(dot.config.paths.notes)
  vim.cmd.edit(year .. '-daylog.md')
end, { desc = 'We have wiki at home' })

vim.keymap.set('n', '<m-t>', scripts.openTerm)
vim.keymap.set('n', '<m-T>', dot_utils.bind(scripts.openTerm, { use_cwd = true }))
