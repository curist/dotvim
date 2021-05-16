call plug#begin('~/.config/nvim/plugged')
" text manipulating helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tomtom/tcomment_vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-lastpat'
Plug 'cohama/lexima.vim'
Plug 'curist/highlight.vim'
Plug 'guns/vim-sexp'

" moving around:
"   file/buffer switching
"   in file quick jumps
Plug 'cocopon/vaffle.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tracyone/fzf-funky', {'on': 'FzfFunky'}


" git
Plug 'tpope/vim-fugitive'

" programming language
let g:polyglot_disabled = ['autoindent', 'sensible', 'vue']
Plug 'sheerun/vim-polyglot'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'Olical/conjure'

" get fancy
Plug 'itchyny/lightline.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lifepillar/vim-gruvbox8'
Plug 'folke/lsp-colors.nvim'

" other handy plugins
Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }
Plug 'tpope/vim-repeat'
Plug 'mklabs/split-term.vim'
Plug 'vim-test/vim-test'

call plug#end()
