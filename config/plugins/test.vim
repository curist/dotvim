let test#strategy = 'neovim'
let test#neovim#term_position = 'vert botright'

nn <silent> <leader>tn :TestNearest<cr>
nn <silent> <leader>tl :TestLast<cr>
nn <silent> <leader>tf :TestFile<cr>

let g:test#javascript#jest#executable = 'npx jest'

