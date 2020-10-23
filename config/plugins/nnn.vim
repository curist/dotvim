let g:nnn#set_default_mappings = 0
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.9, 'highlight': 'Debug' } }

nnoremap <silent> <leader>N :NnnPicker<CR>
nnoremap <silent> <leader>n :NnnPicker %:p:h<CR>
