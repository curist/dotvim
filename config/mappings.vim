let mapleader = ","
let maplocalleader = ","

nn <silent> <leader>h :noh<cr>
nn <silent> <leader>q :QFix<cr>

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" other sweet mappings
nn <silent> <SPACE> za
nmap <c-c> <nop>
vmap <c-c> <esc>
smap <c-c> <esc>
nn <leader><leader> <c-^>
nn <silent> <leader>d <c-w><c-c>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

cmap <expr> <c-r><c-l> getline('.')

nn <f1> <nop>
nn <silent> <up> gk<c-y>
nn <silent> <down> gj<c-e>
nn <silent> <left> :prev<cr>
nn <silent> <right> :next<cr>

" Emacs bindings..
inoremap <c-a> <c-o>^
cnoremap <c-a> <home>
inoremap <c-e> <end>

" moving between windows
nn <m-j> <c-w>j
nn <m-k> <c-w>k
nn <m-l> <c-w>l
nn <m-h> <c-w>h
tnoremap <m-j> <c-\><c-n><c-w>j
tnoremap <m-k> <c-\><c-n><c-w>k
tnoremap <m-l> <c-\><c-n><c-w>l
tnoremap <m-h> <c-\><c-n><c-w>h

" moving between tabs
nn <silent> <m-H> :tabp<cr>
nn <silent> <m-L> :tabn<cr>
tnoremap <silent> <m-H> <c-\><c-n>:tabp<cr>
tnoremap <silent> <m-L> <c-\><c-n>:tabn<cr>
nn <silent> <c-PageUp> :tabp<cr>
nn <silent> <c-PageDown> :tabn<cr>
tnoremap <silent> <c-PageUp> <c-\><c-n>:tabp<cr>
tnoremap <silent> <c-PageDown> <c-\><c-n>:tabn<cr>

" quickfix quick navigation
nn <silent> <m-n> :cn<cr>zz
nn <silent> <m-p> :cp<cr>zz

augroup MyFileTypeMappings
  " run settings
  autocmd!
  autocmd FileType javascript nn <buffer> <leader>r :w<cr>:!node %<cr>
  autocmd FileType typescript nn <buffer> <leader>r :w<cr>:!deno %<cr>
  autocmd FileType janet nn <buffer> <leader>r :w<cr>:VT janet <c-r>%<cr>
augroup END
