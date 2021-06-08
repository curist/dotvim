call plug#begin('~/.config/nvim/plugged')
" text manipulating helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tomtom/tcomment_vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-lastpat'
Plug 'cohama/lexima.vim'
Plug 'curist/highlight.vim'
Plug 'matze/vim-move'

" moving around:
"   file/buffer switching
"   in file quick jumps
Plug 'cocopon/vaffle.vim', { 'on': 'Vaffle' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tracyone/fzf-funky', { 'on': 'FzfFunky' }

" git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify', { 'on': 'SignifyToggle' }

" programming language
let g:polyglot_disabled = ['autoindent', 'sensible', 'vue']
Plug 'sheerun/vim-polyglot'
Plug 'leafOfTree/vim-vue-plugin'

" ( love )
Plug 'guns/vim-sexp'
Plug 'Olical/conjure'
Plug 'Olical/aniseed', { 'do': ':lua compileFennelConfig()' }

" get fancy
Plug 'itchyny/lightline.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lifepillar/vim-gruvbox8'
Plug 'ryanoasis/vim-devicons'

" other handy plugins
Plug 'tpope/vim-repeat'
Plug 'mklabs/split-term.vim'
Plug 'vim-test/vim-test'

call plug#end()
