let mapleader = ","

" snippet editing helper
nn <leader>es :UltiSnipsEdit<cr>

nn <silent> <leader>h :noh<cr>
nn <silent> <leader>q :QFix<cr>


" Visually select the text that was last edited/pasted
nmap gV `[v`]

" other sweet mappings
nn <silent> <SPACE> za
nn <silent> <F4> :execute 'noautocmd vimgrep /\v(TODO\|FIXME)/ '.expand('%')<cr>:copen<cr>:cc<cr>
nn <silent> <F5> <ESC>:set paste!<cr>
nn <silent> <leader>s :execute 'noautocmd vimgrep /'.expand('<cword>').'/j **/*.'.expand('%:e')<cr>:copen<cr>
nn <silent> <leader>S :execute 'noautocmd vimgrep /'.expand('<cword>').'/j **/*'<cr>:copen<cr>
nn <silent> <leader>z :execute 'noautocmd vimgrep /'.expand('<cword>').'/gj '.expand('%')<cr>:copen<cr>
vn <silent> <leader>s :<c-u>noautocmd vimgrep /<c-r>*/j **/*.<c-r>=expand('%:e')<cr><cr>:copen<cr>
vn <silent> <leader>S :<c-u>noautocmd vimgrep /<c-r>*/j **/*<cr>:copen<cr>
vn <silent> <leader>z :<c-u>noautocmd vimgrep /<c-r>*/gj <c-r>=expand('%')<cr><cr>:copen<cr>
nmap <c-c> <nop>
vmap <c-c> <esc>
lmap <c-c> <esc>
smap <c-c> <esc>
nn <leader><leader> <c-^>
nn <silent> <leader>d :bd<cr>

" easier wrapped line navigation
" nn j gj
" nn k gk

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

cmap <expr> <c-r><c-l> getline('.')

nn <f1> <nop>
nn <silent> <up> gk<c-y>
nn <silent> <down> gj<c-e>
nn <silent> <left> :prev<cr>
nn <silent> <right> :next<cr>

" Emacs love section {{{
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

  " quickfix quick navigation
  nn <silent> <m-n> :cn<cr>zz
  nn <silent> <m-p> :cp<cr>zz

  if !has("gui_running")
    nm j <m-j>
    nm k <m-k>
    nm l <m-l>
    nm h <m-h>

    nm n <m-n>
    nm p <m-p>
  endif
" }}}


" PluginMappings {{{
  " FZF
  nn <silent> <leader>f :Files<cr>

  " NERDTree
  nn <silent> <leader>nf :NERDTreeFind<cr>zz
  nn <silent> <leader>nt :NERDTreeToggle<cr>
  " unmap NERDTreeMapCWD
  let g:NERDTreeMapCWD = ''

  " fugitive
  nnoremap <silent> <leader>gs :Gstatus<cr>
  nnoremap <silent> <leader>gc :Gcommit -a<cr>
  nnoremap <silent> <leader>ga :Gcommit -a --amend<cr>
  nnoremap <silent> <leader>gd :Gdiff<cr>
  nnoremap <silent> <leader>gb :Gblame -w<cr>

  " gitv
  nnoremap <silent> <leader>gl :GV<cr>

  " vim-commentary
  xmap <c-_> <Plug>Commentary
  nmap <c-_> <Plug>CommentaryLine
" }}}

augroup MyFileTypeMappings
  " run settings
  autocmd!
  autocmd FileType go nn <buffer> <leader>r :w<cr>:!go run %<cr>
  autocmd FileType go nn <buffer><silent> <c-]> :GoDef<cr>
  autocmd FileType go nn <buffer><silent> <c-t> <c-o>
  autocmd FileType python nn <buffer> <leader>r :w<cr>:!python %<cr>
  autocmd FileType lua nn <buffer> <leader>r :w<cr>:make<cr>
  autocmd FileType javascript nn <buffer> <leader>r :w<cr>:!node %<cr>
  autocmd FileType typescript nn <buffer> <leader>r :w<cr>:!deno %<cr>
  autocmd FileType janet nn <buffer> <leader>r :w<cr>:VT janet <c-r>%<cr>
augroup END
