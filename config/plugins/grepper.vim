let g:grepper               = {}
let g:grepper.tools         = ['rg']
let g:grepper.jump          = 1
let g:grepper.simple_prompt = 1
nmap <leader>S  :Grepper<cr>
nmap <leader>s  <plug>(GrepperOperator)
xmap <leader>s  <plug>(GrepperOperator)
