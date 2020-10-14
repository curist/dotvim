call plug#begin('~/.config/nvim/plugged')

augroup Plugins
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " text manipulating helpers
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'curist/vim-autoclose'
  Plug 'curist/highlight.vim'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Plug 'mcchrish/nnn.vim'
  Plug 'hotoo/jsgf.vim'

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim', { 'on': 'GV' }
  Plug 'vim-scripts/gitignore'

  " programming language
  Plug 'sheerun/vim-polyglot'

  " get fancy
  Plug 'itchyny/lightline.vim'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'rafi/awesome-vim-colorschemes'

  " other handy plugins
  Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }
  Plug 'mklabs/split-term.vim'

augroup END
call plug#end()
