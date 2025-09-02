set fileencoding=utf-8

let mapleader=' '
let maplocalleader=','

" no matter what, no cursor underline
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white

set tabstop=4
set shiftwidth=2
set expandtab
set noshowmode
set noruler
set cmdheight=0
set laststatus=3
set shada='900
set undofile
set undolevels=1000
set undoreload=10000

set mouse=vn
set nowrap
set foldmethod=indent " fold by method (indent & syntax are both good)
set foldlevelstart=9  " we want all fold to be expand at start
set foldnestmax=9     " max fold nest levels
set hidden            " it's ok to switch buffer w/o saving

set title
set clipboard^=unnamed,unnamedplus

set wildmode=list:longest,full
set completeopt=menuone,noselect

set list
set listchars=tab:▸\ ,trail:·,precedes:←,extends:→,nbsp:×
set fillchars=eob:\ 
set showbreak=↪\      " redundant comment to retain the extra space

set ignorecase " ignore case in general
set smartcase  " when we typed something in Capitalized, be case sensitive
set inccommand=nosplit

set nobackup
set noswapfile

set shortmess+=I        " no intro message
set shortmess+=c        " no more pattern not found
set synmaxcol=150       " Don't try to highlight long lines

set updatetime=350
set timeoutlen=400

set splitright

" disable sql completion on i<c-c>
let g:omni_sql_no_default_maps = 1
