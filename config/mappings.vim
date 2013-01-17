let mapleader = ","

" vimrc editing helper
nn <leader>ev :e $MYVIMRC<cr>

" snippet editing helper
nn <leader>es :vne ~/.vim/snippets/<c-r>=&filetype<cr>.snippets<cr>

nn <silent> <leader>h :noh<cr>
nn <silent> <leader>q :QFix<cr>

" mapping to make copy/paste to clipboard easier
vmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>P "+P

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" other sweet mappings
nn <silent> <SPACE> za
nn <silent> <F4> :execute 'noautocmd vimgrep /\v(TODO\|FIXME)/ '.expand('%')<cr>:copen<cr>:cc<cr>
nn <silent> <F5> <ESC>:set paste!<cr>
nn <silent> <leader>s :execute 'noautocmd vimgrep /'.expand('<cword>').'/j **/*.'.expand('%:e')<cr>:copen<cr>
nn <silent> <leader>S :execute 'noautocmd vimgrep /'.expand('<cword>').'/j **/*'<cr>:copen<cr>
nn <silent> <leader>z :execute 'noautocmd vimgrep /'.expand('<cword>').'/gj '.expand('%')<cr>:copen<cr>
vn <silent> <leader>s :<c-w>noautocmd vimgrep /<c-r>*/j **/*.<c-r>=expand('%:e')<cr><cr>:copen<cr>
vn <silent> <leader>S :<c-w>noautocmd vimgrep /<c-r>*/j **/*<cr>:copen<cr>
vn <silent> <leader>z :<c-w>noautocmd vimgrep /<c-r>*/gj <c-r>=expand('%')<cr><cr>:copen<cr>
vmap <c-c> <esc>
lmap <c-c> <esc>
smap <c-c> <esc>
ca <silent> w!! silent exe "write !sudo tee % >/dev/null"
nn <leader><leader> <c-^>
nn <silent> <leader>d :bd<cr>

" Emacs love section {{{2

" some preparations..
nm j <m-j>
nm k <m-k>
nm l <m-l>
nm h <m-h>

nm p <m-p>
nm n <m-n>

" binding for transpose words
nm t <m-t>
cm t <m-t>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" easier wrapped line navigation
nn j gj
nn k gk

" moving between windows
nn <m-j> <c-w>j
nn <m-k> <c-w>k
nn <m-l> <c-w>l
nn <m-h> <c-w>h

nn <silent> <m-n> :cn<cr>
nn <silent> <m-p> :cp<cr>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" map <cr> to do Highlighting only in modifiable buffers
autocmd BufEnter * if &modifiable == 1 && mapcheck("<cr>") == "" |
      \ nn <buffer> <silent> <expr> <CR> Highlighting() |
      \ endif


augroup PluginMappings
  " CtrlP
  nn <silent> <leader>t :CtrlPFunky<cr>
  nn <silent> <leader>g :CtrlPTag<cr>
  let g:ctrlp_map = '<leader>f'

  " NERDTree
  nn <silent> <leader>nf :NERDTreeFind<cr>
  nn <silent> <F2> :NERDTreeToggle<cr>

  " Tagbar
  nn <silent> <F3> :TagbarToggle<cr>

  " Tabuarize mappings
  vnoremap <silent> <leader>a=  :Tabularize /=/l1l1<CR>
  vnoremap <silent> <leader>a,  :Tabularize /,/l0l1<CR>
  vnoremap <silent> <leader>a:  :Tabularize /:/l0l1<CR>
  vnoremap <silent> <leader>a"  :Tabularize /"/l2l1<CR>

  " fugitive
  nnoremap <silent> <leader>gs :Gstatus<cr>
  nnoremap <silent> <leader>gc :Gcommit -a<cr>
  nnoremap <silent> <leader>ga :Gcommit -a --amend<cr>
  nnoremap <silent> <leader>gd :Gdiff<cr>
  nnoremap <silent> <leader>gD :call MyCloseDiff()<cr>

  " gitv
  nnoremap <silent> <leader>gl :Gitv<cr>

  " gundo
  nnoremap <silent> <leader>gu :GundoToggle<cr>
augroup END
