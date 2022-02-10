let mapleader = ","

nn <silent> <leader>C :cd ~/.config/nvim<cr>:Vaffle<cr>

nn <silent> <leader>h <cmd>nohls<cr>
nn <silent> <leader>q :lua require('dot.qf').toggle_list()<cr>

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" other sweet mappings
nn <silent> <SPACE> za
imap <c-c> <esc>
vmap <c-c> <esc>
smap <c-c> <esc>
nmap <silent> <c-c> :lua require('dot.scripts').clear_all()<cr>

nn <silent> <leader><leader> :lua require('dot.scripts').altfile()<cr>
nn <silent> <leader>d <c-w><c-c>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

cmap <expr> <c-r><c-l> getline('.')

nn <silent> <up> gk<c-y>
nn <silent> <down> gj<c-e>
nn <silent> <left> hzh
nn <silent> <right> lzl

" Emacs bindings..
inoremap <c-a> <c-o>^
cnoremap <c-a> <home>
inoremap <c-e> <end>

inoremap <silent> <m-d> <c-r>=system('date +%Y/%b/%d \| xargs echo -n')<cr>

" moving between windows
nn <m-j> <c-w>j
nn <m-k> <c-w>k
nn <m-l> <c-w>l
nn <m-h> <c-w>h

tnoremap <esc><esc> <c-\><c-n>
tnoremap <m-j> <c-\><c-n><c-w>j
tnoremap <m-k> <c-\><c-n><c-w>k
tnoremap <m-l> <c-\><c-n><c-w>l
tnoremap <m-h> <c-\><c-n><c-w>h

" moving between tabs
nn <silent> <c-PageUp> :tabp<cr>
nn <silent> <c-PageDown> :tabn<cr>
nn <silent> <c-s-PageUp> :tabm -1<cr>
nn <silent> <c-s-PageDown> :tabm +1<cr>
tnoremap <silent> <c-PageUp> <c-\><c-n>:tabp<cr>
tnoremap <silent> <c-PageDown> <c-\><c-n>:tabn<cr>
tnoremap <silent> <c-s-PageUp> <c-\><c-n>:tabm -1<cr>
tnoremap <silent> <c-s-PageDown> <c-\><c-n>:tabm +1<cr>

" quickfix quick navigation
nn <silent> <m-n> :lua require('dot.qf').local_list_next()<cr>zz
nn <silent> <m-p> :lua require('dot.qf').local_list_prev()<cr>zz

" treesitter fun
nn <silent> gs :lua require'dot.ts'.print_node_at_cursor()<cr>
nn <silent> gt :lua require'dot.ts'.goto_top_node_at_cursor()<cr>
nn <silent> <c-m-j> :lua require'dot.ts'.swap_top_nodes_at_cursor 'next'<cr>
nn <silent> <c-m-k> :lua require'dot.ts'.swap_top_nodes_at_cursor 'prev'<cr>
nn <silent> <c-m-l> :lua require'dot.ts'.swap_nodes_at_cursor 'next'<cr>
nn <silent> <c-m-h> :lua require'dot.ts'.swap_nodes_at_cursor 'prev'<cr>
nn <silent> <c-j> :lua require'dot.ts'.goto_next_top_node()<cr>
nn <silent> <c-k> :lua require'dot.ts'.goto_prev_top_node()<cr>

" quick notes
nn <silent> <leader>ww :cd $HOME/notes<cr>:e index.md<cr>

augroup MyFileTypeMappings
  " run settings
  autocmd!
  autocmd FileType javascript nn <buffer> <leader>r :w<cr>:!node %<cr>
  autocmd FileType typescript nn <buffer> <leader>r :w<cr>:!deno %<cr>
  autocmd FileType lua nn <buffer> <leader>r :w<cr>:!lua %<cr>
augroup END
