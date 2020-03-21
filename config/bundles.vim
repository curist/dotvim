call plug#begin('~/.config/nvim/plugged')

augroup Plugins
  " text manipulating helpers
  Plug 'curist/vim-autoclose'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'curist/highlight.vim'
  " Plug 'tpope/vim-endwise'
  " Plug 'vim-scripts/vim-indent-object'
  " Plug 'vim-scripts/transpose-words'

  " moving around:
  "   file/buffer switching
  "   in file quick jumps
  Plug 'vim-scripts/matchit.zip'
  Plug 'scrooloose/nerdtree'
  Plug 'mileszs/ack.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'vim-scripts/bufexplorer.zip'

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/gitignore'
  " Plug 'junegunn/gv.vim'

  " language specific
  Plug 'sheerun/vim-polyglot'

  " lsp
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " get fancy
  Plug 'chriskempson/base16-vim'
  " Plug 'whatyouhide/vim-gotham'

  " other handy plugins
  Plug 'vim-scripts/vimwiki'
  Plug 'tpope/vim-repeat'
  Plug 'mklabs/split-term.vim'
  " Plug 'vim-scripts/MatchTag'
augroup END
call plug#end()
