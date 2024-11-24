local dot = require 'dot.utils'
local dot_scripts = require 'dot.scripts'
local dot_qf = require 'dot.qf'
local w = dot.bind -- wrap aka bind

local function nn(...) vim.keymap.set('n', unpack(dot.concat({...}, {{silent = true}}))) end
local function vn(...) vim.keymap.set('v', unpack(dot.concat({...}, {{silent = true}}))) end

nn('<c-c>', dot_scripts.clear_all)
nn('<leader>q', dot_qf.toggle_list, { desc = 'Toggle quickfix' })

nn('gV', '`[v`]', { desc = 'Select last edited/pasted text' })

-- other sweet mappings
vim.keymap.set({'i', 'v', 's'}, '<c-c>', '<esc>')
vim.keymap.set('i', '<c-l>', 'λ')

nn('<leader>`', '<c-^>', { desc = 'Previous buffer' })
nn('<leader>wd', '<c-w><c-c>', { desc = 'Delete window' })
nn('<leader>ws', '<c-w>s', { desc = 'Split window' })
nn('<leader>wv', '<c-w>v', { desc = 'Vertical split window' })

-- Keep the cursor in place while joining lines
nn('J', 'mzJ`z')

vim.keymap.set('c', '<c-r><c-l>', w(vim.fn.getline, '.'), { expr = true })

nn('<up>', 'gk<c-y>')
nn('<down>', 'gj<c-e>')
nn('<left>', 'hzh')
nn('<right>', 'lzl')
nn('<s-up>', ":m .-2<cr>==", { desc = 'Move line up' })
nn('<s-down>', ":m .+1<cr>==", { desc = 'Move line down' })
vn('<s-up>', ":m '<-2<cr>gv=gv", { desc = 'Move selection up' })
vn('<s-down>', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })

-- Emacs bindings..
vim.keymap.set({'i', 'c'}, '<c-a>', '<home>')
vim.keymap.set('i', '<c-e>', '<end>')

-- current date
vim.keymap.set('i', '<m-d>', w(os.date, '%Y/%b/%d'), { expr = true })

-- quickfix quick navigation
nn('<m-n>', dot_qf.local_list_next)
nn('<m-p>', dot_qf.local_list_prev)

-- quick notes
nn('<leader>ww', function()
  local year = vim.fn.strftime'%Y'
  vim.fn.execute('cd $HOME/notes')
  vim.fn.execute(('e %s-daylog.md'):format(year))
end, { desc = "We have wiki at home" })

