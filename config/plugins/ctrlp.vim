let g:ctrlp_map = ''

let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

nn <silent> <leader>f :CtrlP<cr>
nn <silent> <leader>m :CtrlPMRUFiles<cr>
