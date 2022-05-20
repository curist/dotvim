local dot = require 'dot.utils'
local dot_scripts = require 'dot.scripts'
local dot_qf = require 'dot.qf'
local dot_ts = require 'dot.ts'
local w = dot.bind -- wrap aka bind

local function nn(...) vim.keymap.set('n', unpack(dot.concat({...}, {{silent = true}}))) end
local function tn(...) vim.keymap.set('t', unpack(dot.concat({...}, {{silent = true}}))) end

nn('<leader>C', ':cd ~/.config/nvim<cr>:Vaffle<cr>')

nn('<leader>h', dot_scripts.clear_all)
nn('<leader>q', dot_qf.toggle_list)

-- Visually select the text that was last edited/pasted
nn('gV', '`[v`]')

-- other sweet mappings
nn('<space>', 'za')
vim.keymap.set({'n', 'i', 'v', 's'}, '<c-c>', '<esc>')
vim.keymap.set('i', '<c-l>', 'λ')

nn('<leader><leader>', dot_scripts.altfile)
nn('<leader>d', '<c-w><c-c>')

-- Keep the cursor in place while joining lines
nn('J', 'mzJ`z')

vim.keymap.set('c', '<c-r><c-l>', w(vim.fn.getline, '.'), { expr = true })

nn('<up>', 'gk<c-y>')
nn('<down>', 'gj<c-e>')
nn('<left>', 'hzh')
nn('<right>', 'lzl')

-- Emacs bindings..
vim.keymap.set('i', '<c-a>', '<c-o>^')
vim.keymap.set('c', '<c-a>', '<home>')
vim.keymap.set('i', '<c-e>', '<end>')

-- current date
vim.keymap.set('i', '<m-d>', w(vim.fn.system, 'date +%Y/%b/%d | xargs echo -n'), { expr = true })

-- moving between windows
nn('<m-j>', '<c-w>j')
nn('<m-k>', '<c-w>k')
nn('<m-h>', '<c-w>h')
nn('<m-l>', '<c-w>l')

-- neovim term bindings
tn('<esc><esc>', '<c-\\><c-n>')
tn('<m-j>', '<c-\\><c-n><c-w>j')
tn('<m-k>', '<c-\\><c-n><c-w>k')
tn('<m-l>', '<c-\\><c-n><c-w>l')
tn('<m-h>', '<c-\\><c-n><c-w>h')

-- moving between tabs
nn('<c-pageup>', ':tabp<cr>')
nn('<c-pagedown>', ':tabn<cr>')
nn('<c-s-pageup>', ':tabm -1<cr>')
nn('<c-s-pagedown>', ':tabm +1<cr>')
tn('<c-pageup>', '<c-\\><c-n>:tabp<cr>')
tn('<c-pagedown>', '<c-\\><c-n>:tabn<cr>')
tn('<c-s-pageup>', '<c-\\><c-n>:tabm -1<cr>')
tn('<c-s-pagedown>', '<c-\\><c-n>:tabm +1<cr>')

-- quickfix quick navigation
nn('<m-n>', dot_qf.local_list_next)
nn('<m-p>', dot_qf.local_list_prev)

-- treesitter fun
nn('gs', dot_ts.print_node_at_cursor)
nn('gt', dot_ts.goto_top_node_at_cursor)
nn('<c-m-j>', w(dot_ts.swap_top_nodes_at_cursor, 'next'))
nn('<c-m-k>', w(dot_ts.swap_top_nodes_at_cursor, 'prev'))
nn('<c-m-l>', w(dot_ts.swap_nodes_at_cursor, 'next'))
nn('<c-m-h>', w(dot_ts.swap_nodes_at_cursor, 'prev'))
nn('<c-j>', dot_ts.goto_next_top_node)
nn('<c-k>', dot_ts.goto_prev_top_node)

-- quick notes
nn('<leader>ww', function()
  local year = vim.fn.strftime'%Y'
  vim.fn.execute('cd $HOME/notes')
  vim.fn.execute(('e %s-daylog.md'):format(year))
end)

