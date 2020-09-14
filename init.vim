runtime! bundles.vim
runtime! config/**/*.vim

language messages POSIX

set fileformat=unix
set fileencoding=utf-8

set termguicolors
colorscheme embark

" no matter what, no cursor underline
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white

set viminfo='500

" match ErrorMsg '\%>80v.\+'
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set noshowmode

set mouse=vn
set nowrap
set foldmethod=indent " fold by method (indent & syntax are both good)
set foldlevelstart=99 " we want all fold to be expand at start
set foldnestmax=15    " max fold nest levels
set hidden     " it's ok to switch buffer w/o saving

set clipboard^=unnamed,unnamedplus
set guioptions+=a

set wildmode=list:longest,full
set completeopt=noinsert,menuone,noselect

set list
set listchars=tab:▸\ ,trail:·,precedes:←,extends:→,nbsp:×
set showbreak=↪\      " redundant comment to retain the extra space

set ignorecase " ignore case in general
set smartcase  " when we typed something in Capitalized, be case sensitive
set inccommand=nosplit

set nobackup
set noswapfile

set shortmess+=I               " no intro message
set virtualedit=block          " no limit cursor postion in VISUAL BLOCK mode
set synmaxcol=300              " Don't try to highlight long lines

set updatetime=250
set timeoutlen=500

" vim: ts=4 sw=2 sts=2 et foldenable foldmethod=marker
