language messages POSIX
set fileformat=unix
set fileencoding=utf-8
set termguicolors

runtime! bundles.vim
runtime! config/**/*.vim

for luacfg in split(glob('~/.config/nvim/config/**/*.lua'))
  exec 'luafile ' . luacfg
endfor

let g:gruvbox_italicize_strings = 0
colorscheme gruvbox8

" no matter what, no cursor underline
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white

set viminfo='500

set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set noshowmode
set nomodeline

set mouse=vn
set nowrap
set foldmethod=indent " fold by method (indent & syntax are both good)
set foldlevelstart=9  " we want all fold to be expand at start
set foldnestmax=5     " max fold nest levels
set hidden     " it's ok to switch buffer w/o saving

set clipboard^=unnamed,unnamedplus
set guioptions+=a

set wildmode=list:longest,full
set completeopt=menuone,noselect
set signcolumn=number

set list
set listchars=tab:▸\ ,trail:·,precedes:←,extends:→,nbsp:×
set showbreak=↪\      " redundant comment to retain the extra space

set ignorecase " ignore case in general
set smartcase  " when we typed something in Capitalized, be case sensitive
set inccommand=nosplit

set nobackup
set noswapfile

set shortmess+=I               " no intro message
set shortmess+=c               " no more pattern not found
set virtualedit=block          " no limit cursor postion in VISUAL BLOCK mode
set synmaxcol=150              " Don't try to highlight long lines

set updatetime=350
set timeoutlen=400

let $GIT_EDITOR = 'nvr -cc split --remote-wait'
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

" vim: ts=4 sw=2 sts=2 et foldenable foldmethod=marker
