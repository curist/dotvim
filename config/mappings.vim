let mapleader = ","

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
vn <silent> <leader>s :<c-u>noautocmd vimgrep /<c-r>*/j **/*.<c-r>=expand('%:e')<cr><cr>:copen<cr>
vn <silent> <leader>S :<c-u>noautocmd vimgrep /<c-r>*/j **/*<cr>:copen<cr>
vn <silent> <leader>z :<c-u>noautocmd vimgrep /<c-r>*/gj <c-r>=expand('%')<cr><cr>:copen<cr>
vmap <c-c> <esc>
lmap <c-c> <esc>
smap <c-c> <esc>
ca <silent> w!! silent exe "write !sudo tee % >/dev/null"
nn <leader><leader> <c-^>
nn <silent> <leader>d :bd<cr>

" easier wrapped line navigation
nn j gj
nn k gk

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

cmap <expr> <c-r><c-l> getline('.')

" map <cr> to do Highlighting only in modifiable buffers
autocmd BufEnter * if &modifiable == 1 && mapcheck("<cr>") == ""|
      \ nn <buffer> <silent> <expr> <CR> Highlighting()|
      \ xn <buffer> <silent> <expr> <CR> HighlightingSelected()|
      \ endif


" Emacs love section {{{
  " Emacs bindings..
  inoremap <c-a> <c-o>^
  inoremap <expr> <c-e> col('.')>strlen(getline('.'))?"\<lt>c-e>":"\<lt>end>"
  cnoremap <c-a> <home>

  " moving between windows
  nn <m-j> <c-w>j
  nn <m-k> <c-w>k
  nn <m-l> <c-w>l
  nn <m-h> <c-w>h

  " quickfix quick navigation
  nn <silent> <m-n> :cn<cr>
  nn <silent> <m-p> :cp<cr>

  if !has("gui_running")
    nm j <m-j>
    nm k <m-k>
    nm l <m-l>
    nm h <m-h>

    nm n <m-n>
    nm p <m-p>

    " binding for transpose words
    nm t <m-t>
    cm t <m-t>
  endif
" }}}


" PluginMappings {{{
  " CtrlP
  nn <silent> <leader>t :CtrlPBufTag<cr>
  nn <silent> <leader>g :CtrlPTag<cr>
  let g:ctrlp_map = '<leader>f'

  " NERDTree
  nn <silent> <leader>nf :NERDTreeFind<cr>
  nn <silent> <F2> :NERDTreeToggle<cr>
  " unmap NERDTreeMapCWD
  let g:NERDTreeMapCWD = ''

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
" }}}

augroup MyFileTypeMappings
  " run settings
  autocmd FileType c nn <buffer> <leader>r :w<cr>:!gcc % -o /tmp/%:t:r<cr>:!/tmp/%:t:r<cr>
  autocmd FileType cpp nn <buffer> <leader>r :w<cr>:!g++ % -o /tmp/%:t:r<cr>:!/tmp/%:t:r<cr>
  autocmd FileType objc nn <buffer> <leader>r :w<cr>:!gcc % `gnustep-config --objc-flags` -lgnustep-base -o /tmp/%:t:r<cr>:!/tmp/%:t:r<cr>
  autocmd FileType cs nn <buffer> <leader>r :w<cr>:!mcs %<cr>:!mono %:r.exe<cr>
  autocmd FileType java nn <buffer> <leader>r :w<cr>:!javac %<cr>:!java %:t:r<cr>
  autocmd FileType python nn <buffer> <leader>r :w<cr>:!python %<cr>
  autocmd FileType perl nn <buffer> <leader>r :w<cr>:!perl %<cr>
  autocmd FileType lua nn <buffer> <leader>r :w<cr>:make<cr>
  autocmd FileType javascript nn <buffer> <leader>r :w<cr>:!node %<cr>
  autocmd FileType coffee nn <buffer> <leader>r :w<cr>:!coffee %<cr>
  autocmd FileType coffee vn <buffer> <leader>r :w !coffee -s<cr>
  autocmd FileType coffee nn <buffer> <leader>c :w<cr>:!coffee -p %<cr>
  autocmd FileType coffee vn <buffer> <leader>c :w !coffee -psb<cr>
  autocmd FileType ruby nn <buffer> <leader>r :w<cr>:!ruby %<cr>
  autocmd FileType markdown
        \ nn <buffer> <leader>r
        \ :w<cr>:!markdown % > /tmp/%:t:r.html && firefox -new-tab /tmp/%:t:r.html<cr>
  autocmd FileType javascript nn <buffer><silent> <leader>t :CtrlPFunky<cr>

  autocmd FileType clojure nn <buffer><silent> <leader>et mz0vab:VimShellSendString<cr>`z
augroup END
