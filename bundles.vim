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
  Plug 'romainl/vim-qf'
  Plug 'liuchengxu/vim-clap'

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/gitignore'

  " programming language
  Plug 'neovim/nvim-lsp'
  Plug 'sheerun/vim-polyglot'

  " get fancy
  Plug 'chriskempson/base16-vim'
  Plug 'itchyny/lightline.vim'

  " other handy plugins
  Plug 'vimwiki/vimwiki'
  Plug 'tpope/vim-repeat'
  Plug 'mklabs/split-term.vim'

  " misc
  " Plug 'haorenW1025/completion-nvim'
  Plug 'Olical/conjure', {'tag': 'v3.4.0'}
  Plug 'Olical/aniseed', { 'tag': 'v3.5.0' }
  Plug 'bakpakin/fennel.vim'

augroup END
call plug#end()
