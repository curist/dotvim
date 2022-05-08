(function(setup_plugins)
  vim.call('plug#begin', '~/.config/nvim/plugged')
  setup_plugins(function (name, args)
    args = args or { x = 1 }
    -- workaround lua `do` & `for` keyword
    args['do'] = args.run
    args['for'] = args.ft
    vim.call('plug#', name, args)
    if args.config and type(args.config) == 'function' then
      vim.schedule(args.config)
    end
  end)
  vim.call('plug#end')
end)(function(Plug)
  Plug 'nvim-lua/plenary.nvim'

  -- text manipulating helpers
  Plug 'tpope/vim-surround'
  Plug('tomtom/tcomment_vim', { on = 'TComment' })
  Plug 'cohama/lexima.vim'
  Plug 'curist/highlight.vim'

  -- moving around:
  --   file/buffer switching
  --   in file quick jumps
  Plug 'cocopon/vaffle.vim'
  Plug 'ibhagwan/fzf-lua'
  Plug 'phaazon/hop.nvim'

  -- tree-sitter
  Plug('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  Plug 'nvim-treesitter/playground'

  -- git
  Plug 'tpope/vim-fugitive'
  Plug('mhinz/vim-signify', { on = 'SignifyToggle' })

  -- lsp & completions etc.
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'jose-elias-alvarez/null-ls.nvim'

  -- specific programming language
  Plug('bfredl/nvim-luadev', { ft = 'lua' })

  -- get fancy
  Plug 'itchyny/lightline.vim'
  Plug('vv9k/bogster', {
    config = function()
      vim.cmd('hi Search guibg=Orange')
    end,
  })

  -- other handy plugins
  Plug 'tpope/vim-repeat'
  Plug 'vim-test/vim-test'
  -- Plug 'github/copilot.vim'
end)
