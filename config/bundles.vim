call plug#begin('~/.config/nvim/plugged')

augroup Plugins
  " the plugin
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " text manipulating helpers
  Plug 'curist/vim-autoclose'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'curist/highlight.vim'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Plug 'scrooloose/nerdtree'

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/gitignore'

  " programming language
  Plug 'sheerun/vim-polyglot'

  " get fancy
  Plug 'chriskempson/base16-vim'
  Plug 'itchyny/lightline.vim'

  " other handy plugins
  Plug 'vim-scripts/vimwiki'
  Plug 'tpope/vim-repeat'
  Plug 'mklabs/split-term.vim'
augroup END
call plug#end()
