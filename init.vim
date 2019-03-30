filetype off

runtime! config/**/*.vim

syntax on
filetype plugin indent on
language messages POSIX

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,utf-16le,iso8859-1

" fav colors: gotham gruvbox
set termguicolors
colorscheme gotham

set cursorline
set colorcolumn=80
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

set clipboard=
set guioptions+=a

set wildmenu
set wildmode=list:longest,full

set completeopt=noinsert,menuone,noselect

set list
set listchars=tab:▸\ ,trail:·,precedes:←,extends:→,nbsp:×
set showbreak=↪

set formatoptions-=o

set sidescroll=1

set ignorecase " ignore case in general
set smartcase  " when we typed something in Capitalized, be case sensitive
set incsearch
set hlsearch

set nobackup
set noswapfile
set backupcopy=yes
set backupdir=/tmp
set directory=/tmp

set shortmess+=I               " no intro message
set iminsert=1                 " to enable lmap
set nrformats=hex,alpha        " ctrl-a to increment a-zA-Z
set virtualedit=block          " no limit cursor postion in VISUAL BLOCK mode
set synmaxcol=200              " Don't try to highlight long lines

set updatetime=250

" vim: ts=4 sw=2 sts=2 et foldenable foldmethod=marker
