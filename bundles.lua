(function(setup_plugins)
  vim.call('plug#begin', '~/.config/nvim/plugged')
  setup_plugins(function (name, args)
    args = args or { x = 1 }
    -- workaround lua `do` & `for` keyword
    args['do'] = args.run
    args['for'] = args.ft
    vim.call('plug#', name, args)
  end)
  vim.call('plug#end')
end)(function(Plug)
  -- text manipulating helpers
  Plug 'tpope/vim-surround'
  Plug('tomtom/tcomment_vim', { on = 'TComment' })
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'cohama/lexima.vim'
  Plug 'curist/highlight.vim'

  -- moving around:
  --   file/buffer switching
  --   in file quick jumps
  Plug 'cocopon/vaffle.vim'
  Plug 'ibhagwan/fzf-lua'
  Plug 'phaazon/hop.nvim'

  -- git
  Plug 'tpope/vim-fugitive'
  Plug('mhinz/vim-signify', { on = 'SignifyToggle' })

  -- programming language
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  Plug 'dense-analysis/ale'
  Plug('bfredl/nvim-luadev', { ft = 'lua' })

  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/nvim-cmp'

  -- get fancy
  Plug 'itchyny/lightline.vim'
  Plug 'vv9k/bogster'

  -- other handy plugins
  Plug 'tpope/vim-repeat'
  Plug 'curist/split-term.vim'
  Plug 'vim-test/vim-test'
  Plug 'kevinhwang91/nvim-bqf'
  Plug 'github/copilot.vim'
end)
