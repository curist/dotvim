set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

augroup Bundles
  " text manipulating helpers
  Bundle 'curist/vim-AutoClose'
  Bundle 'godlygeek/tabular'
  Bundle 'tpope/vim-surround'
  Bundle 'tpope/vim-endwise'
  Bundle 'tpope/vim-commentary'
  Bundle 'transpose-words'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Bundle 'mru.vim'
  Bundle 'matchit.zip'
  Bundle 'bufexplorer.zip'
  Bundle 'scrooloose/nerdtree'
  Bundle 'Tagbar'
  Bundle 'kien/ctrlp.vim'
  Bundle 'tacahiroy/ctrlp-funky'
  Bundle 'repmo.vim'
  Bundle 'mileszs/ack.vim'

  " git
  Bundle 'tpope/vim-fugitive'

  " language specific
  Bundle 'vim-ruby/vim-ruby'
  Bundle 'tpope/vim-rails'
  Bundle 'tpope/vim-markdown'
  Bundle 'MatchTag'
  Bundle 'pangloss/vim-javascript'
  Bundle 'digitaltoad/vim-jade'
  Bundle 'kchmck/vim-coffee-script'
  Bundle 'javacomplete'
  Bundle 'walm/jshint.vim'
  Bundle 'hail2u/vim-css3-syntax'
  Bundle 'cakebaker/scss-syntax.vim'
  Bundle 'aaronj1335/underscore-templates.vim'

  " other handy plugins
  Bundle 'vimwiki'
  Bundle 'ervandew/supertab'
  Bundle 'tpope/vim-rake'
  Bundle 'tpope/vim-repeat'
  Bundle 'chrisbra/NrrwRgn'
  Bundle 'UltiSnips'
  Bundle 'sjl/gundo.vim'
  Bundle 'henrik/vim-indexed-search'

  " good to have
  " Bundle 'scrooloose/syntastic'
  " Bundle 'YankRing.vim'
  " Bundle 'wincent/Command-T'
  " Bundle 'sjl/splice.vim'
  " Bundle 'gregsexton/gitv'
  " Bundle 'wavded/vim-stylus'
augroup END

syntax on
filetype plugin indent on
language messages POSIX

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,utf-16le,iso8859-1

set t_Co=256
"desert256 herald tir_black lucius inkpot zenburn
"xoria256 wombat256i vividchalk molokai jellybeans
colorscheme molokai
set cursorline

set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set mouse=vn
set nowrap
set foldmethod=indent " fold by method (indent & syntax are both good)
set foldlevelstart=99 " we want all fold to be expand at start
set foldnestmax=15    " max fold nest levels
set autoindent
set backspace=indent,eol,start
set hidden     " it's ok to switch buffer w/o saving
set showcmd

set wildmenu

set laststatus=2                          " status bar setting
set statusline=[%F]                       " file name
set statusline+=\ [%{&fileencoding},      " encoding
set statusline+=%{&fileformat}]           " file format
set statusline+=%{&paste?'\ [PASTE]':''}  " paste mode status
set statusline+=%m                        " file modified?
set statusline+=%=%{fugitive#head(6)}     " git branch
set statusline+=\ %y                      " filetype
set statusline+=\ %c,\ %l\ \/\ %L         " cursor position, total lines

let g:bufExplorerFindActive=0
let g:mapleader = ","

set list
set listchars=tab:▸\ ,trail:·,precedes:←,extends:→,nbsp:×

set formatoptions-=o

set sidescroll=1

set ignorecase " ignore case in general
set smartcase  " when we typed something in Capitalized, be case sensitive
set incsearch
set hlsearch

set nobackup
set noswapfile
set backupdir=/tmp
set directory=/tmp

set shortmess+=I              " no intro message
set iminsert=1                " to enable lmap
set nrformats=octal,hex,alpha " ctrl-a to increment a-zA-Z
set virtualedit=block         " no limit cursor postion when in VISUAL BLOCK mode

augroup MyFileTypeSettings
  autocmd FileType javascript,ruby,eruby,yaml,vim,coffee,html,markdown,vimwiki,jade setlocal ai sw=2 sts=2 et
  autocmd FileType python setlocal ai sw=4 sts=4 et

  " markdown and vimwiki wrap lines
  autocmd FileType markdown,vimwiki setlocal wrap
  autocmd FileType vimwiki setlocal nohidden
  autocmd FileType vimwiki setlocal filetype=markdown.vimwiki

  " exclusive use cindent for c and cpp
  autocmd FileType c,h,cpp,hpp setlocal cindent

  " java complete setting
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType java setlocal completefunc=javacomplete#Complete

  " c/c++ compiletion settings"
  autocmd FileType c setlocal mp=gcc\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r
  autocmd FileType cpp setlocal mp=g++\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r

  " lua quickfix settings "
  autocmd FileType lua setlocal mp=lua\ %
  autocmd BufRead *.lua setlocal efm=lua:\ %f:%l:%m

  " tintin++ setting
  autocmd BufEnter,BufNew *.tt setlocal syntax=tt

  " javascript files run JSHint upon save
  autocmd FileType javascript autocmd BufWritePost <buffer> exe ":JSHint"

  " sqlpython buffer skips parsing by wrap the sql in REMARK BEGIN and REMARK END
  autocmd BufNewFile,BufRead afiedt.buf setfiletype sql
  autocmd BufWritePre afiedt.buf call SqlRemarkWrapping()

  " remap sql omni-completion
  let g:ftplugin_sql_omni_key = '<c-j>'

  " xml formatting
  autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ --encode\ utf-8\ -

  "" killing trailing spaces when saving file
  autocmd FileType c,cpp,java,php,python,perl,ruby,javascript,vim autocmd BufWritePre <buffer> :call KillTrailingSpaces()

  " run settings
  autocmd FileType c nn <buffer> <leader>r :w<cr>:!gcc % -o ~/bin/%:t:r<cr>:!~/bin/%:t:r<cr>
  autocmd FileType cpp nn <buffer> <leader>r :w<cr>:!g++ % -o ~/bin/%:t:r<cr>:!~/bin/%:t:r<cr>
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
  autocmd FileType markdown nn <buffer> <leader>r :w<cr>:!markdown % > /tmp/%:t:r.html && firefox -new-tab /tmp/%:t:r.html<cr>
augroup END

" git-vim
let g:git_no_map_default = 1

" UltiSnips settings
let g:UltiSnipsSnippetDirectories=["snippets"]
" snippet editing helper
nn <leader>es :vne ~/.vim/snippets/<c-r>=&filetype<cr>.snippets<cr>

" ctrlp settings
nn <silent> <leader>t :CtrlPFunky<cr>
nn <silent> <leader>g :CtrlPTag<cr>
let g:ctrlp_map = '<leader>f'
let g:ctrlp_extensions = ['funky']
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.hg$\|\.svn$\|node_modules$',
      \ 'file': '\.exe$\|\.so$\|\.dll$\|\.class$\|\.pyc$\|\.png$\|\.jpeg$\|\.jpg$\|\.gif$\|\.bmp$'
      \ }

" supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
set ofu=syntaxcomplete#Complete
set completeopt=menu,longest

" deconflicting mappings between bufexplorer and surround
autocmd BufEnter \[BufExplorer\] unmap ds
autocmd BufLeave \[BufExplorer\] nmap ds <Plug>Dsurround

" don't show quickfix in buffers list
" set number in quickfix list
autocmd BufRead quickfix setlocal nobuflisted number

" rails settings
let g:rubycomplete_rails = 1

" tagbar
let g:tagbar_sort = 0

" NrrwRgn window maximize as default
autocmd BufEnter * let b:nrrw_aucmd_create = "%wincmd _"

" vimwiki
let g:vimwiki_hl_headers = 1
let g:vimwiki_ext2syntax = {}
let g:vimwiki_list = [{'syntax': 'markdown'}]

" ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" repmo
let g:repmo_mapmotions = "j|k h|l <C-E>|<C-Y> zh|zl gj|gk"

" mapping to make copy/paste to clipboard easier
vmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>P "+P

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" other sweet mappings
nn <silent> <SPACE> za
nn <silent> <F2> <ESC>:NERDTreeToggle<cr>
nn <silent> <F3> <ESC>:TagbarToggle<cr>
nn <silent> <F4> :execute 'noautocmd vimgrep /\v(TODO\|FIXME)/ '.expand('%')<cr>:copen<cr>:cc<cr>
nn <silent> <F5> <ESC>:set paste!<cr>
nn <silent> <leader>s :execute 'noautocmd vimgrep /'.expand('<cword>').'/j **/*.'.expand('%:e')<cr>:copen<cr>
nn <silent> <leader>S :execute 'noautocmd vimgrep /'.expand('<cword>').'/j **/*'<cr>:copen<cr>
nn <silent> <leader>z :execute 'noautocmd vimgrep /'.expand('<cword>').'/gj '.expand('%')<cr>:copen<cr>
vn <silent> <leader>s :<c-w>noautocmd vimgrep /<c-r>*/j **/*.<c-r>=expand('%:e')<cr><cr>:copen<cr>
vn <silent> <leader>S :<c-w>noautocmd vimgrep /<c-r>*/j **/*<cr>:copen<cr>
vn <silent> <leader>z :<c-w>noautocmd vimgrep /<c-r>*/gj <c-r>=expand('%')<cr><cr>:copen<cr>
nn <silent> <c-n> :cn<cr>
nn <silent> <c-p> :cp<cr>
vmap <c-c> <esc>
lmap <c-c> <esc>
smap <c-c> <esc>
ca <silent> w!! silent exe "write !sudo tee % >/dev/null"
nn <leader><leader> <c-^>
" binding for transpose words
nm t <m-t>
cm t <m-t>



cabbr ss syntax sync fromstart

" moving between windows
nn <c-j> <c-w>j
nn <c-k> <c-w>k
nn <c-l> <c-w>l
nn <c-h> <c-w>h

" NERDTree options
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeChDirMode = 2
let g:NERDTreeMouseMode = 2
let g:NERDTreeDirArrows = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
nn <silent> <leader>nf :NERDTreeFind<cr>

function! Highlighting()
  " just in case..
  if &modifiable != 1
    return "\<cr>"
  endif

  " check if the current word is meaningful
  if expand('<cword>') =~ '^[a-zA-Z][a-zA-Z#_0-9]*$'
    let @/ = '\<'.expand('<cword>').'\>'
  endif
  return ":silent set hlsearch\<cr>:ShowSearchIndex\<cr>"
endfunction
autocmd BufEnter * if &modifiable == 1 && mapcheck("<cr>") == "" |
      \ nn <buffer> <silent> <expr> <CR> Highlighting() |
      \ endif
nn <silent> <leader>h :noh<cr>

" toggles the quickfix window.
command -bang -nargs=0 QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
  else
    copen 10
  endif
endfunction
nn <silent> <leader>q :QFix<cr>

" used to track the quickfix window
augroup QFixToggle
  autocmd!
  autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
  autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END

function! KillTrailingSpaces()
  let save_cursor = getpos('.')
  :%s/\s\+$//e
  :call cursor(save_cursor[1], save_cursor[2], save_cursor[3])
  unlet save_cursor
endfunction

function! SqlRemarkWrapping()
  execute "norm ggOREMARK BEGIN"
  execute "norm Gk"
  if search(';', 'nW') == 0
    execute "norm Go;"
  endif
  execute "norm GoREMARK END"
endfunction

" Load project specific configs
if filereadable(expand("./.local_vimrc"))
  source ./.local_vimrc
endif
