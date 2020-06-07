call plug#begin('~/.config/nvim/plugged')

augroup Plugins
  " text manipulating helpers
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'curist/vim-autoclose'
  Plug 'curist/highlight.vim'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Plug 'preservim/nerdtree'
  Plug 'Yggdroot/LeaderF'
  Plug 'romainl/vim-qf'

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/gitignore'

  " completion
  Plug 'haorenW1025/completion-nvim'

  " programming language
  Plug 'neovim/nvim-lsp'
  Plug 'sheerun/vim-polyglot'

  " get fancy
  " Plug 'chriskempson/base16-vim'
  Plug 'sainnhe/edge'
  Plug 'itchyny/lightline.vim'

  " other handy plugins
  Plug 'vimwiki/vimwiki'
  Plug 'tpope/vim-repeat'
  Plug 'mklabs/split-term.vim'
augroup END
call plug#end()
