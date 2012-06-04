set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

augroup Bundles
  " text manipulating helpers
  Bundle 'tpope/vim-surround'
  Bundle 'curist/vim-AutoClose'
  Bundle 'tpope/vim-endwise'
  Bundle 'godlygeek/tabular'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Bundle 'mru.vim'
  Bundle 'matchit.zip'
  Bundle 'bufexplorer.zip'
  Bundle 'scrooloose/nerdtree'
  Bundle 'Tagbar'
  Bundle 'kien/ctrlp.vim'

  " git
  Bundle 'motemen/git-vim'
  Bundle 'tpope/vim-fugitive'
  Bundle 'gregsexton/gitv'

  " language specific
  Bundle 'vim-ruby/vim-ruby'
  Bundle 'tpope/vim-rails'
  Bundle 'digitaltoad/vim-jade'
  Bundle 'kchmck/vim-coffee-script'
  Bundle 'pangloss/vim-javascript'
  Bundle 'javacomplete'
  Bundle 'tpope/vim-markdown'

  " other handy plugins
  Bundle 'vimwiki'
  Bundle 'SuperTab-continued.'
  Bundle 'tpope/vim-rake'
  Bundle 'tpope/vim-repeat'
  Bundle 'mileszs/ack.vim'
  Bundle 'chrisbra/NrrwRgn'
  Bundle 'UltiSnips'

  " good to have
  " Bundle 'sjl/threesome.vim'
  " Bundle 'sjl/gundo.vim'
  " Bundle 'scrooloose/syntastic'
  " Bundle 'YankRing.vim'
  " Bundle 'wincent/Command-T'
  " Bundle 'repmo.vim'
augroup END

syntax on
filetype plugin indent on
language messages POSIX

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,iso8859-1

set t_Co=256
"desert256 herald tir_black baycomb lucius inkpot jellybeans xoria256 wombat256i zenburn
colorscheme jellybeans
highlight Pmenu ctermbg=300 gui=bold
set cursorline

set number
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set mouse=vn
set nowrap
set foldmethod=indent " fold by method (indent & syntax are both good)
set foldlevelstart=99 " we want all fold to be expand at start
set foldnestmax=3     " we want 3 fold levels at max
set autoindent
set backspace=indent,eol,start
set hidden     " it's ok to switch buffer w/o saving

set wildmenu

set laststatus=2                                      " status bar setting
set statusline=[%F]                                   " file name
set statusline+=\ [%{&fileencoding},                  " encoding
set statusline+=%{&fileformat}]                       " file format
set statusline+=%{HasPaste()}                         " paste mode status
set statusline+=%m                                    " file modified?
set statusline+=%=%{GitBranch()}\ %y\ %l,\ %c\ \<%P\> " git branch

let g:bufExplorerFindActive=0
let mapleader = ","

set list
set listchars=tab:>-,trail:-

set formatoptions-=o

set sidescrolloff=5
set sidescroll=1

set ignorecase " ignore case in general
set smartcase  " when we typed something in Capitalized, be case sensitive
set incsearch
set hlsearch

set nobackup
set noswapfile

set shortmess+=I " no intro message

augroup MyFileTypeSettings
  autocmd FileType javascript,python,ruby,eruby,yaml,vim,coffee set ai sw=2 sts=2 et
  " manpage don't show line number
  autocmd FileType man set number!

  " exclusive use cindent for c and cpp
  autocmd FileType c,h,cpp,hpp setlocal cindent

  autocmd FileType vimwiki setlocal nohidden

  " java complete setting
  autocmd FileType java set omnifunc=javacomplete#Complete
  autocmd FileType java set completefunc=javacomplete#Complete

  " c/c++ compiletion settings"
  autocmd FileType c set mp=gcc\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r
  autocmd FileType cpp set mp=g++\ -g\ -Wall\ %\ -o\ ~/bin/%:t:r

  " lua quickfix settings "
  autocmd FileType lua setlocal mp=lua\ %
  autocmd BufRead *.lua setlocal efm=lua:\ %f:%l:%m

  " tintin++ setting
  autocmd BufEnter,BufNew *.tt set syntax=tt

  "" killing trailing spaces when saving file
  autocmd FileType c,cpp,java,php,python,perl,ruby,javascript,vim autocmd BufWritePre <buffer> :call KillTrailingSpaces()

  " run settings
  autocmd FileType c nn <leader>r :w<cr>:!gcc % -o ~/bin/%:t:r<cr>:!~/bin/%:t:r<cr>
  autocmd FileType cpp nn <leader>r :w<cr>:!g++ % -o ~/bin/%:t:r<cr>:!~/bin/%:t:r<cr>
  autocmd FileType cs nn <leader>r :w<cr>:!mcs %<cr>:!mono %:r.exe<cr>
  autocmd FileType java nn <leader>r :w<cr>:!javac %<cr>:!java %:t:r<cr>
  autocmd FileType python nn <leader>r :w<cr>:!python %<cr>
  autocmd FileType perl nn <leader>r :w<cr>:!perl %<cr>
  autocmd FileType lua nn <leader>r :w<cr>:make<cr>
  autocmd FileType javascript nn <leader>r :w<cr>:!node %<cr>
  autocmd FileType coffee nn <leader>r :w<cr>:!coffee %<cr>
  autocmd FileType coffee vn <leader>r ::w !coffee -s<cr>
  autocmd FileType coffee nn <leader>c :w<cr>:!coffee -p %<cr>
  autocmd FileType coffee vn <leader>c ::w !coffee -psb<cr>
  autocmd FileType ruby nn <leader>r :w<cr>:!ruby %<cr>
  " markdown preview, use the same key binding as
  " running scripts just feel right
  autocmd FileType markdown nn <leader>r :w<cr>:!markdown % > /tmp/%:t:r.html && firefox -new-tab /tmp/%:t:r.html<cr>
augroup END


" UltiSnips settings
let g:UltiSnipsSnippetDirectories=["snippets"]

" ctrlp settings
let g:ctrlp_map = '<leader>t'
let g:ctrlp_working_path_mode = 0

" supertab
" let g:SuperTabDefaultCompletionType = "context"
set ofu=syntaxcomplete#Complete
set completeopt=menu,longest

" deconflicting mappings between bufexplorer and surround
autocmd BufEnter \[BufExplorer\] unmap ds
autocmd BufLeave \[BufExplorer\] nmap ds <Plug>Dsurround

" don't show quickfix in buffers list
autocmd BufRead quickfix setlocal nobuflisted

" rails settings
let g:rubycomplete_rails = 1

" tagbar
let g:tagbar_sort = 0

" mapping to make copy/paste to clipboard easier
vmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>P "+P

" mappings to make indention easier
" nn <tab> >>
" nn <s-tab> <<
vn <tab> >gv
vn <s-tab> <gv

" other sweet mappings
nn <silent> <SPACE> za
nn <silent> <F12> :set number!<cr>
nn <silent> <F2> <ESC>:NERDTreeToggle<cr>
nn <silent> <F3> <ESC>:TagbarToggle<cr>
nn <silent> <F4> <ESC>:Ack! TODO<cr>
nn <silent> <F5> <ESC>:set paste!<cr>
nn <silent> <leader>s :Ack!<cr>
nn <silent> <c-n> :cn<cr>
nn <silent> <c-p> :cp<cr>
vn <c-c> <esc>
ca <silent> w!! silent exe "write !sudo tee % >/dev/null"

" complete unclosed xml tag
im <c-j> <esc>F<lyt>$a</">

" moving between windows
nn <c-j> <c-w>j
nn <c-k> <c-w>k
nn <c-l> <c-w>l
nn <c-h> <c-w>h

" vimwiki
let g:vimwiki_hl_headers = 1

" ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" NERDTree options
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeChDirMode = 2
let g:NERDTreeMouseMode = 2
let g:NERDTreeDirArrows = 1
let g:NERDTreeQuitOnOpen = 0
nn <silent> <leader>nf :NERDTreeFind<cr>

let g:highlighting = 0
function! Highlighting()
  if &filetype=="qf"
    return "\<cr>"
  endif
  "if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
  if g:highlighting == 1 && @/ =~ expand('<cword>')
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif

  " check if the current word is meaningful
  if expand('<cword>') =~ '^[a-zA-Z][a-zA-Z#_0-9]*$'
    let @/ = '\<'.expand('<cword>').'\>'
  " or we just check the g:highlighting to toggle highlight
  elseif g:highlighting == 1
      let g:highlighting = 0
      return ":silent nohlsearch\<CR>"
  endif

  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
nn <silent> <expr> <CR> Highlighting()
nn <silent> n :let g:highlighting=1<cr>n
nn <silent> N :let g:highlighting=1<cr>N
nn <silent> / :let g:highlighting=1<cr>/
nn <silent> ? :let g:highlighting=1<cr>?
nn <silent> <leader>h :noh<cr>:let g:highlighting=0<cr>

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

function! HasPaste()
  if &paste
    return '[PASTE MODE]'
  end
  return ''
endfunction
