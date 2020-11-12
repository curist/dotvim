call plug#begin('~/.config/nvim/plugged')

augroup Plugins
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tracyone/fzf-funky', {'on': 'FzfFunky'}

  " text manipulating helpers
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-abolish'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'curist/vim-autoclose'
  Plug 'curist/highlight.vim'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Plug 'mcchrish/nnn.vim'

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/gitignore'

  " programming language
  Plug 'sheerun/vim-polyglot'
  Plug 'natebosch/vim-lsc'
  Plug 'lepture/vim-velocity'

  " get fancy
  Plug 'itchyny/lightline.vim'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'rafi/awesome-vim-colorschemes'

  " other handy plugins
  Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }
  Plug 'tpope/vim-repeat'
  Plug 'mklabs/split-term.vim'
  Plug 'vim-test/vim-test'

augroup END
call plug#end()
