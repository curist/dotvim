call plug#begin('~/.config/nvim/plugged')

augroup Plugins
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tracyone/fzf-funky', {'on': 'FzfFunky'}

  " text manipulating helpers
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-abolish'
  Plug 'tomtom/tcomment_vim'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'curist/vim-autoclose'
  Plug 'curist/highlight.vim'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Plug 'cocopon/vaffle.vim'

  " git
  Plug 'tpope/vim-fugitive'

  " programming language
  let g:polyglot_disabled = ['autoindent', 'sensible', 'vue']
  Plug 'sheerun/vim-polyglot'
  Plug 'natebosch/vim-lsc'
  Plug 'lepture/vim-velocity'
  Plug 'leafOfTree/vim-vue-plugin'

  " get fancy
  Plug 'itchyny/lightline.vim'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'rafi/awesome-vim-colorschemes'
  Plug 'lifepillar/vim-gruvbox8'

  " other handy plugins
  Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }
  Plug 'tpope/vim-repeat'
  Plug 'mklabs/split-term.vim'
  Plug 'vim-test/vim-test'

augroup END
call plug#end()
