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

  -- git
  Plug 'tpope/vim-fugitive'
  Plug('mhinz/vim-signify', { on = 'SignifyToggle' })

  -- programming language
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  Plug('bfredl/nvim-luadev', { ft = 'lua' })
  Plug('dense-analysis/ale', {
    config = function()
      vim.g.ale_disable_lsp = true
      vim.g.ale_set_loclist = true
      vim.g.ale_set_quickfix = false
    end,
  })

  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/nvim-cmp'

  -- get fancy
  Plug 'itchyny/lightline.vim'
  Plug 'vv9k/bogster'

  -- other handy plugins
  Plug 'tpope/vim-repeat'
  Plug 'vim-test/vim-test'
  Plug 'github/copilot.vim'
end)
