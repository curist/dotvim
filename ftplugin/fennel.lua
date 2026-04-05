local ft = require('dot.ft')

ft.buf_nn('=', 'gq')
vim.keymap.set('x', '=', 'gq', { buffer = true, silent = true })
ft.buf_nn('==', 'gqq')
ft.run_current_file('fennel')
